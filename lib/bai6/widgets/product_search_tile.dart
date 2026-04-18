// bai6/widgets/product_search_tile.dart

import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductSearchTile extends StatelessWidget {
  final ProductModel product;
  const ProductSearchTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: product.image.isNotEmpty
            ? Image.network(
                product.image,
                width: 48,
                height: 48,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported),
              )
            : const Icon(Icons.shopping_bag),
        title: Text(
          product.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        subtitle: Text(product.category),
        trailing: Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
