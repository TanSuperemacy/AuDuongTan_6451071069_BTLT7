// bai4/controllers/user_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserController {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<UserModel> fetchUser(int userId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      return UserModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
    throw Exception('Không tải được user: ${response.statusCode}');
  }

  Future<UserModel> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/users/${user.id}'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
    throw Exception('Cập nhật thất bại: ${response.statusCode}');
  }
}
