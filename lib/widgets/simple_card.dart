import 'package:flutter/material.dart';
import 'package:newsapp/screens/news_article.dart';
import 'package:transparent_image/transparent_image.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
    required this.content,
    required this.description,
  });
  final String title;
  final String imageUrl;
  final String author;
  final String publishedAt;
  final String content;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return NewsArticle(
                    title: title,
                    imageUrl: imageUrl,
                    content: content,
                    author: author,
                    description: description,
                  );
                },
              ),
            );
          },
          child: Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(
                  imageUrl,
                ),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrYSO7XxA7DrtCs3I2uqfmLN0xabwDJ1PCBmgBSPv2_A&s');
                },
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color.fromARGB(134, 82, 78, 78),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    author,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  publishedAt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
