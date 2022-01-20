import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  int get itemsCount => _items.length;

  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int position = _items.indexWhere((p) => p.id == product.id);

    if (position >= 0) {
      _items[position] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int position = _items.indexWhere((p) => p.id == product.id);

    if (position >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}