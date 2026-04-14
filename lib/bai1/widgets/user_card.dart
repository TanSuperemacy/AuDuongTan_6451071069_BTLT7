// bai1/widgets/user_card.dart
// Bài 1: Widget hiển thị 1 user trong danh sách

import 'package:flutter/material.dart';
import '../models/user.dart';

/// Card hiển thị tên + email + phone của một User
class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text(
            user.name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            Text(user.phone, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
