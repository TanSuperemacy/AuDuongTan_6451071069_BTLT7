// bai3/controllers/post_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostController {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Gửi POST request tạo bài viết mới
  Future<PostModel> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    final url = Uri.parse('$_baseUrl/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(PostModel(title: title, body: body, userId: userId).toJson()),
    );

    if (response.statusCode == 201) {
      return PostModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Lỗi tạo bài viết: ${response.statusCode}');
    }
  }
}
