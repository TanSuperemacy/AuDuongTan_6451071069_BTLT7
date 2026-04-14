// bai1/utils/api_service.dart
// Bài 1: Tiện ích gọi HTTP để lấy danh sách User

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  /// GET /users → `List<User>`
  static Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 (Linux; Android) Flutter/3.0',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Lỗi khi tải danh sách user: ${response.statusCode}');
    }
  }
}
