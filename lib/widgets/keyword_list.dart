import 'package:flutter/material.dart';
import 'package:newsapp/widgets/keyword_item.dart';

class KeywordsList extends StatelessWidget {
  KeywordsList({super.key});
  final list = [
    'Politics',
    'Economy',
    'Technology',
    'Science',
    'Health',
    'Sports',
    'Entertainment',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var keyword in list)
            Keyword(
              keyword: keyword,
            ),
        ],
      ),
    );
  }
}
