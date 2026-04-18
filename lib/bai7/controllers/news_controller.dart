// bai7/controllers/news_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsController {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<NewsModel>> fetchNews({int limit = 10}) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/posts?_limit=$limit'));
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list
          .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Không tải được tin tức: ${response.statusCode}');
  }
}
