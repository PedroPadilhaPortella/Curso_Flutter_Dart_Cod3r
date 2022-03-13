import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/constants.dart';

import 'cart.dart';

/// Provider dos Pedidos
class OrderList with ChangeNotifier {
  String _token;
  List<Order> _items = [];

  OrderList(this._token, this._items);

  List<Order> get items => [..._items];

  /// Método responsável por retornar a quantidade de pedidos
  int get itemsCount => _items.length;

  /// Método responsável por adicionar um novo pedido
  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.baseUrlOrders}.json?auth=$_token'),
      body: jsonEncode({
        "total": cart.totalAmount,
        "date": date.toIso8601String(),
        "products": cart.items.values
            .map((cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'name': cartItem.name,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                })
            .toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }

  /// Método responsável por carregar os pedidos
  Future<void> loadOrders() async {
    List<Order> items = [];

    final response = await http
        .get(Uri.parse('${Constants.baseUrlOrders}.json?auth=$_token'));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((id, order) {
      items.add(Order(
        id: id,
        date: DateTime.parse(order['date']),
        total: order['total'],
        products: (order['products'] as List<dynamic>)
            .map((item) => CartItem(
                  id: item['id'],
                  name: item['name'],
                  quantity: item['quantity'],
                  price: item['price'],
                  productId: item['productId'],
                ))
            .toList(),
      ));
    });

    _items = items.reversed.toList();
    notifyListeners();
  }
}
