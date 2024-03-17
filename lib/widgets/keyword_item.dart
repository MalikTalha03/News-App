import 'package:flutter/material.dart';

class Keyword extends StatelessWidget {
  const Keyword({
    super.key,
    required this.keyword,
  });
  final String keyword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: OutlinedButton(
        onPressed: () {},
        child: Text(
          keyword,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
