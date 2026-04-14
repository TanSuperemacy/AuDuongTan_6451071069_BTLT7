// bai2/views/product_detail_view.dart
// Bài 2: Màn hình chi tiết sản phẩm

import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/api_service.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

/// Màn hình Bài 2:
/// - Gọi API GET https://fakestoreapi.com/products/{id}
/// - Tạo Product.fromJson() từ object JSON trả về
/// - Hiển thị loading khi đang tải
/// - Hiển thị lỗi nếu thất bại
/// - Hiển thị title, price, description khi thành công
class ProductDetailView extends StatelessWidget {
  /// ID sản phẩm cần hiển thị (mặc định = 1 để demo)
  final int productId;

  const ProductDetailView({super.key, this.productId = 1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 2 - Chi tiết Sản phẩm - 6451071069'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // FutureBuilder tự động quản lý trạng thái: waiting / error / done
      body: FutureBuilder<Product>(
        future: ApiService.fetchProduct(productId),
        builder: (context, snapshot) {
          // ── Đang tải ──────────────────────────
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          // ── Gặp lỗi ───────────────────────────
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: 'Không thể tải sản phẩm.\n${snapshot.error}',
            );
          }

          // ── Không có dữ liệu ──────────────────
          if (!snapshot.hasData) {
            return const AppErrorWidget(message: 'Sản phẩm không tồn tại.');
          }

          // ── Hiển thị chi tiết sản phẩm ────────
          final product = snapshot.data!;
          return _buildProductDetail(product);
        },
      ),
    );
  }

  /// Xây dựng giao diện chi tiết sản phẩm bằng Column
  Widget _buildProductDetail(Product product) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình sản phẩm
          Center(
            child: Image.network(
              product.image,
              height: 220,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const SizedBox(
                  height: 220,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 80, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 16),

          // Danh mục
          Chip(
            label: Text(
              product.category.toUpperCase(),
              style: const TextStyle(fontSize: 11),
            ),
            backgroundColor: Colors.indigo.shade50,
          ),

          const SizedBox(height: 8),

          // Tên sản phẩm (title)
          Text(
            product.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          // Giá (price)
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),

          const Divider(height: 28),

          // Mô tả (description)
          const Text(
            'Mô tả sản phẩm',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
