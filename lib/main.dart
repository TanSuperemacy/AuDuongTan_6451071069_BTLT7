// main.dart - Entry point của ứng dụng
// HomeMenu routing giữa Bài 1 → Bài 7

import 'package:flutter/material.dart';

import 'bai1/views/user_list_view.dart';
import 'bai2/views/product_detail_view.dart';
import 'bai3/views/create_post_view.dart';
import 'bai4/views/update_user_view.dart';
import 'bai5/views/task_list_view.dart';
import 'bai6/views/search_product_view.dart';
import 'bai7/views/news_list_view.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget - cấu hình theme và routing
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BTTL 10 - API Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeMenu(),
      routes: {
        '/bai1': (context) => const UserListView(),
        '/bai2': (context) => const ProductDetailView(productId: 1),
        '/bai3': (context) => const CreatePostView(),
        '/bai4': (context) => const UpdateUserView(userId: 1),
        '/bai5': (context) => const TaskListView(),
        '/bai6': (context) => const SearchProductView(),
        '/bai7': (context) => const NewsListView(),
      },
    );
  }
}

/// Màn hình menu chọn Bài 1 → Bài 7
class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuItem('/bai1', Icons.people, 'Bài 1: Fetch User List (GET API)', Colors.deepPurple),
      _MenuItem('/bai2', Icons.shopping_bag, 'Bài 2: Product Detail (GET + JSON Parsing)', Colors.indigo),
      _MenuItem('/bai3', Icons.edit, 'Bài 3: Create Post (POST API)', Colors.teal),
      _MenuItem('/bai4', Icons.person_outline, 'Bài 4: Update User Info (PUT API)', Colors.orange),
      _MenuItem('/bai5', Icons.delete_outline, 'Bài 5: Delete Item (DELETE API)', Colors.red),
      _MenuItem('/bai6', Icons.search, 'Bài 6: Search API (Query Params)', Colors.blue),
      _MenuItem('/bai7', Icons.refresh, 'Bài 7: Pull to Refresh (Data Reload)', Colors.green),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('BTTL 10 - API Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Chọn bài để xem:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: item.color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          alignment: Alignment.centerLeft,
                        ),
                        icon: Icon(item.icon),
                        label: Text(item.label),
                        onPressed: () =>
                            Navigator.pushNamed(context, item.route),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String route;
  final IconData icon;
  final String label;
  final Color color;
  const _MenuItem(this.route, this.icon, this.label, this.color);
}
