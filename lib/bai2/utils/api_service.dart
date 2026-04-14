// bai2/utils/api_service.dart
// Bài 2: Tiện ích gọi HTTP để lấy chi tiết sản phẩm

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  /// GET /products/{id} → [Product]
  static Future<Product> fetchProduct(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/products/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return Product.fromJson(jsonMap);
    } else {
      throw Exception('Lỗi khi tải sản phẩm: ${response.statusCode}');
    }
  }
}
