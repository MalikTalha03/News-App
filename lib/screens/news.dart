import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newsapp/models/headlines.dart';
import 'package:newsapp/providers/headline.dart';
import 'package:newsapp/widgets/country_flag_dropdown.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:newsapp/widgets/keyword_list.dart';
import 'package:newsapp/widgets/news_card.dart';
import 'package:newsapp/widgets/simple_card.dart';

class NewsScreen extends ConsumerStatefulWidget {
  NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  String countryCode = 'us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: AnimSearchBar(
                      width: 350,
                      color: const Color.fromARGB(255, 196, 188, 188),
                      helpText: 'Search for news',
                      textController: TextEditingController(),
                      onSuffixTap: () {},
                      onSubmitted: (text) {},
                    ),
                  ),
                  CountryFlagDropdown(
                    initialValue: FlagsCode.US,
                    onChanged: (selectedCountryCode) {
                      final newCountryCode = selectedCountryCode!.toLowerCase();
                      setState(() {
                        countryCode = newCountryCode;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final AsyncValue<List<Headline>> headlines = ref.watch(
            headlineProvider(
              'https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=9332bca655af45bd8c7525c7fc024e27',
            ),
          );

          return headlines.when(
            data: (headlines) {
              final firstFive = headlines.take(5).toList();
              final remaining = headlines.skip(5).toList();
              if (headlines.isEmpty) {
                return const Center(
                  child: Text('No headlines found'),
                );
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          bottom: 10,
                        ),
                        child: Text(
                          'Top News',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          bottom: 10,
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                'See All',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 28, 134, 221),
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward,
                                color: Color.fromARGB(255, 28, 134, 221),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CarouselSlider(
                    items: firstFive
                        .map(
                          (headline) => NewsCard(
                            title: headline.title,
                            imageUrl: headline.urlToImage,
                            author: headline.author,
                            description: headline.description,
                            publishedAt: headline.publishedAt,
                            content: headline.content,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  KeywordsList(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: remaining.length,
                      itemBuilder: (context, index) {
                        final headline = remaining[index];
                        return Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: SimpleCard(
                            title: headline.title,
                            imageUrl: headline.urlToImage,
                            author: headline.author,
                            publishedAt: headline.publishedAt,
                            content: headline.content,
                            description: headline.description,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Text('Error: $error'),
          );
        },
      ),
    );
  }
}
