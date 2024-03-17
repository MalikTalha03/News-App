import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/headlines.dart';

final headlineProvider =
    FutureProvider.autoDispose.family<List<Headline>, String>((ref, url) async {
  final response = await http.get(Uri.parse(url));
  final statusCode = response.statusCode;
  if (statusCode != 200) {
    throw Exception('Failed to load headlines');
  }
  final responseData = json.decode(response.body);
  final List<dynamic> headlines = responseData['articles'];
  final finalList = headlines
      .map((json) => Headline.fromJson(json))
      .where((headline) =>
          headline.title.isNotEmpty) // Filter out headlines with empty titles
      .toList();

  return finalList;
});
