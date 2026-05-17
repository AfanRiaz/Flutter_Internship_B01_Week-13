import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/fake_api_service.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _page = 0;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  Future<void> loadInitialProducts() async {
    if (_products.isNotEmpty) return;

    await fetchMoreProducts();
  }

  Future<void> fetchMoreProducts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final newProducts = await FakeApiService.fetchProducts(_page);

    if (newProducts.isEmpty) {
      _hasMore = false;
    } else {
      _products.addAll(newProducts);
      _page++;
    }

    _isLoading = false;

    notifyListeners();
  }
}