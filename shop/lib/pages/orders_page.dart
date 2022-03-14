import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // bool _isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<OrderList>(context, listen: false)
  //       .loadOrders()
  //       .then((value) => setState(() => _isLoading = false));
  // }

  @override
  Widget build(BuildContext context) {
    // final OrderList orders = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Pedidos"),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.warning_amber_outlined,
                  size: 42,
                ),
                Text(
                  "Ocorreu um erro ao buscar os pedidos!",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ));
          } else {
            return Consumer<OrderList>(
              builder: (ctx, orders, child) => ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, i) => OrderItem(order: orders.items[i]),
              ),
            );
          }
        },
      ),
    );
  }
}
