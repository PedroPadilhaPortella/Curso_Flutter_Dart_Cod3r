import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/utils/exceptions/http_exception.dart';

/// Provider da Lista de Produtos
class ProductList with ChangeNotifier {
  String _token;
  String _userId;
  List<Product> _items = [];

  ProductList([this._token = '', this._userId = '', this._items = const []]);

  /// Método responsável por retornar todos os pedidos
  List<Product> get items => [..._items];

  /// Método responsável por retornar a quantidade de pedidos
  int get itemsCount => _items.length;

  /// Método responsável por carregar os pedidos
  Future<void> loadProducts() async {
    clearListItems();

    final response = await http
        .get(Uri.parse('${Constants.baseUrlProducts}.json?auth=$_token'));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    final favResponse = await http.get(Uri.parse(
        '${Constants.baseUrlUserFavorites}/$_userId.json?auth=$_token'));

    Map<String, dynamic> favoriteData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    data.forEach((id, product) {
      final isFavorite = favoriteData[id] ?? false;
      _items.add(Product(
        id: id,
        name: product['name'],
        description: product['description'],
        price: product['price'],
        isFavorite: isFavorite,
        imageUrl: product['imageUrl'],
      ));
    });
    notifyListeners();
  }

  /// Método responsável por retornar somente os produtos favoritados
  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  /// Método responsável por salvar um produto
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

  /// Método responsável por adicionar um produto
  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrlProducts}.json?auth=$_token'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));

    notifyListeners();
  }

  /// Método responsável por atualizar um produto
  Future<void> updateProduct(Product product) async {
    int position = _items.indexWhere((p) => p.id == product.id);

    if (position >= 0) {
      await http.patch(
        Uri.parse(
            '${Constants.baseUrlProducts}/${product.id}.json?auth=$_token'),
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
  }

  /// Método responsável por remover um produto
  Future<void> removeProduct(Product product) async {
    int position = _items.indexWhere((p) => p.id == product.id);

    if (position >= 0) {
      final product = _items[position];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(Uri.parse(
          '${Constants.baseUrlProducts}/${product.id}.json?auth=$_token'));

      if (response.statusCode >= 400) {
        _items.insert(position, product);
        notifyListeners();
        throw HttpException(
            mensagem: "Não foi possível excluir o produto",
            statusCode: response.statusCode);
      }
    }
  }

  /// Método responsável por limpar a lista de produtos
  void clearListItems() {
    _items.clear();
  }
}
