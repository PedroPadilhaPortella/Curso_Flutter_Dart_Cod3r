import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

/// Classe Modelo de um Produto
class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  /// Método responsável por alternar a propriedade isFavorite do produto
  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  /// Método responsável por favoritar / desfavoritar determinado produto
  Future<void> toggleFavorite(BuildContext context, String token) async {
    try {
      _toggleFavorite();

      final response = await http.patch(
        Uri.parse('${Constants.baseUrlProducts}/$id.json?auth=$token'),
        body: jsonEncode({"isFavorite": isFavorite}),
      );

      if (response.statusCode >= 400) {
        throwError(context);
      }
    } catch (_) {
      throwError(context);
    }
  }

  /// Método responsável por notificar possível erro que aconteca no processo
  /// de favoritar / desfavoritar um produto
  void throwError(BuildContext context) {
    _toggleFavorite();
    final scaffold = ScaffoldMessenger.of(context);
    scaffold
        .showSnackBar(const SnackBar(content: Text("Erro ao Favoritar item.")));
  }
}
