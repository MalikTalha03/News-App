import 'package:intl/intl.dart';

class Headline {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String source;
  final String author;

  Headline({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.source,
    required this.author,
  });

  Headline.empty()
      : title = '',
        description = '',
        url = '',
        urlToImage =
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrYSO7XxA7DrtCs3I2uqfmLN0xabwDJ1PCBmgBSPv2_A&s',
        publishedAt = '',
        content = '',
        source = '',
        author = '';

  factory Headline.fromJson(Map<String, dynamic> json) {
    if (json['title'] == null) {
      return Headline.empty();
    }
    final formattedDate = DateTime.parse(json['publishedAt']);
    final formattedDateString = DateFormat('yyyy-MM-dd').format(formattedDate);
    return Headline(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
      urlToImage: json['urlToImage'] as String? ??
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrYSO7XxA7DrtCs3I2uqfmLN0xabwDJ1PCBmgBSPv2_A&s',
      publishedAt: formattedDateString,
      content: json['content'] as String? ?? '',
      source: json['source']['name'] as String? ?? '',
      author: json['author'] as String? ?? '',
    );
  }
}
