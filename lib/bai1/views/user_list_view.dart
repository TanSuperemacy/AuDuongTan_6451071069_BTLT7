// bai1/views/user_list_view.dart
// Bài 1: Màn hình danh sách User

import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utils/api_service.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/user_card.dart';

/// Màn hình Bài 1:
/// - Gọi API GET https://jsonplaceholder.typicode.com/users
/// - Hiển thị loading khi đang tải
/// - Hiển thị lỗi nếu thất bại
/// - Hiển thị danh sách user (tên + email) dạng ListView
class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 1 - Danh sách User - 6451071069'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      // FutureBuilder tự động quản lý trạng thái: waiting / error / done
      body: FutureBuilder<List<User>>(
        future: ApiService.fetchUsers(),
        builder: (context, snapshot) {
          // ── Đang tải ──────────────────────────
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          // ── Gặp lỗi ───────────────────────────
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: 'Không thể tải dữ liệu.\n${snapshot.error}',
            );
          }

          // ── Không có dữ liệu ──────────────────
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const AppErrorWidget(message: 'Không có user nào.');
          }

          // ── Hiển thị danh sách ────────────────
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return UserCard(user: users[index]);
            },
          );
        },
      ),
    );
  }
}
