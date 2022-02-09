import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/utils/exceptions/http_exception.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadProducts() async {
    clearListItems();

    final response = await http.get(Uri.parse('${Constants.baseUrl}.json'));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((id, product) {
      _items.add(Product(
        id: id,
        name: product['name'],
        description: product['description'],
        price: product['price'],
        imageUrl: product['imageUrl'],
        isFavorite: product['isFavorite'],
      ));
    });
    notifyListeners();
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}.json'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));

    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int position = _items.indexWhere((p) => p.id == product.id);

    if (position >= 0) {
      await http.patch(
        Uri.parse('${Constants.baseUrl}/${product.id}.json'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );

      _items[position] = product;

      notifyListeners();
    }
    // return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int position = _items.indexWhere((p) => p.id == product.id);

    if (position >= 0) {
      final product = _items[position];
      _items.remove(product);
      notifyListeners();

      final response = await http
          .patch(Uri.parse('${Constants.baseUrl}/${product.id}.json'));

      if (response.statusCode >= 400) {
        _items.insert(position, product);
        notifyListeners();
        throw HttpException(
            mensagem: "Não foi possível excluir o produto",
            statusCode: response.statusCode);
      }
    }
  }

  void clearListItems() {
    _items.clear();
  }
}
