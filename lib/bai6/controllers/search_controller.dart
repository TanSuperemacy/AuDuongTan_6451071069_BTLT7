// bai6/controllers/search_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductSearchController {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductModel>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Không tải được sản phẩm: ${response.statusCode}');
  }

  /// Tìm kiếm theo keyword trong title (client-side filter)
  /// Dùng FakeStore API không hỗ trợ query param q= nên filter ở client
  List<ProductModel> searchByKeyword(
          List<ProductModel> all, String keyword) =>
      keyword.trim().isEmpty
          ? all
          : all
              .where((p) =>
                  p.title.toLowerCase().contains(keyword.toLowerCase()) ||
                  p.category.toLowerCase().contains(keyword.toLowerCase()))
              .toList();
}
