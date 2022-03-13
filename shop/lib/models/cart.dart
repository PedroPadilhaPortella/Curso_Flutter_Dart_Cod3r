import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

/// Provider do Carrinho de Compras
class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  /// Método responsável por retornar os items do carrinho
  Map<String, CartItem> get items {
    return {..._items};
  }

  /// Método responsável por retornar a quantidade de itens do carrinho
  int get itemsCount {
    return _items.length;
  }

  /// Método responsável por retornar a soma total do carrinho
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  /// Método responsável por adicionar um item no carrinho
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  /// Método responsável por remover um item do carrinho
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  /// Método responsável por remover um único item do carrinho
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  /// Método responsável por limpar o carrinho
  void clear() {
    _items = {};
    notifyListeners();
  }
}
