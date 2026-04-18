// bai5/controllers/task_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class TaskController {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<TaskModel>> fetchTasks({int limit = 10}) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/todos?_limit=$limit'));
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list
          .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Không tải được danh sách task: ${response.statusCode}');
  }

  Future<void> deleteTask(int taskId) async {
    final response =
        await http.delete(Uri.parse('$_baseUrl/todos/$taskId'));
    // jsonplaceholder trả về 200 khi xóa thành công
    if (response.statusCode != 200) {
      throw Exception('Xóa thất bại: ${response.statusCode}');
    }
  }
}
