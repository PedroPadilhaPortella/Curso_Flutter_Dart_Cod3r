import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("R\$${widget.order.total.toStringAsFixed(2)}"),
          subtitle:
              Text(DateFormat("dd/MM/yyyy hh:mm").format(widget.order.date)),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            icon: const Icon(Icons.expand_more),
          ),
        ),
        (_expanded)
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: (widget.order.products.length * 25.0) + 10,
                child: ListView(
                  children: widget.order.products.map((product) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${product.quantity}x R\$ ${product.price}",
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              )
            : Container()
      ],
    );
  }
}
