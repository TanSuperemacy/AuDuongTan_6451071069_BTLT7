// main.dart - Entry point của ứng dụng
// MyApp + HomeMenu routing giữa Bài 1 và Bài 2

import 'package:flutter/material.dart';

import 'bai1/views/user_list_view.dart';
import 'bai2/views/product_detail_view.dart';

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
      },
    );
  }
}

/// Màn hình menu chọn Bài 1 hoặc Bài 2
class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BTTL 10 - API Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chọn bài để xem:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // Bài 1
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              icon: const Icon(Icons.people),
              label: const Text('Bài 1: Fetch User List (GET API)'),
              onPressed: () => Navigator.pushNamed(context, '/bai1'),
            ),

            const SizedBox(height: 16),

            // Bài 2
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Bài 2: Product Detail (GET + JSON Parsing)'),
              onPressed: () => Navigator.pushNamed(context, '/bai2'),
            ),
          ],
        ),
      ),
    );
  }
}
