import 'package:flutter/material.dart';

import '../models/models.dart';

class CartProvider with ChangeNotifier {

  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  int get cartCount => _cartItems.length;

  void addToCart(ProductModel product) {

    _cartItems.add(product);

    notifyListeners();
  }

  void removeFromCart(ProductModel product) {

    _cartItems.remove(product);

    notifyListeners();
  }
}