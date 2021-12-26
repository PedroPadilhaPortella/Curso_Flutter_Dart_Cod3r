import 'package:flutter/material.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/data/DUMMY_DATA.dart';
import 'package:shop/models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  final List<Product> loadedProduct = dummyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
      ),
      body: GridView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: dummyData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) => ProductItem(product: loadedProduct[i])),
    );
  }
}
