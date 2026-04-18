// bai6/views/search_product_view.dart

import 'package:flutter/material.dart';
import '../controllers/search_controller.dart';
import '../models/product_model.dart';
import '../widgets/product_search_tile.dart';

class SearchProductView extends StatefulWidget {
  const SearchProductView({super.key});

  @override
  State<SearchProductView> createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView> {
  final _searchCtrl = TextEditingController();
  final _controller = ProductSearchController();

  List<ProductModel> _allProducts = [];
  List<ProductModel> _filtered = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchCtrl.addListener(_onSearch);
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_onSearch);
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _controller.fetchAllProducts();
      setState(() {
        _allProducts = products;
        _filtered = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMsg = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onSearch() {
    setState(() {
      _isSearching = _searchCtrl.text.isNotEmpty;
      _filtered =
          _controller.searchByKeyword(_allProducts, _searchCtrl.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 6: Search Sản Phẩm - 6451071069'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Nhập từ khóa tìm kiếm...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _isSearching
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchCtrl.clear(),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.blue.shade50,
              ),
            ),
          ),
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tìm thấy ${_filtered.length} kết quả',
                  style: TextStyle(color: Colors.blue.shade700, fontSize: 13),
                ),
              ),
            ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMsg != null
                    ? Center(
                        child: Text(_errorMsg!,
                            style: const TextStyle(color: Colors.red)))
                    : _filtered.isEmpty
                        ? const Center(child: Text('Không tìm thấy sản phẩm'))
                        : ListView.builder(
                            itemCount: _filtered.length,
                            itemBuilder: (ctx, i) =>
                                ProductSearchTile(product: _filtered[i]),
                          ),
          ),
        ],
      ),
    );
  }
}
