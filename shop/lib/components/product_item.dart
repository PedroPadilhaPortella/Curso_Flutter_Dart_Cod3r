import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/exceptions/http_exception.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.amber,
              onPressed: () => Navigator.of(context)
                  .pushNamed(AppRoutes.PRODUCTS_FORM, arguments: product),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              // onPressed: () => Provider.of<ProductList>(context, listen: false)
              //     .removeProduct(product),
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir?'),
                    content: const Text("Deseja remover o Produto?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Não")),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Sim"))
                    ],
                  ),
                ).then((value) async {
                  try {
                    if (value ?? false) {
                      await Provider.of<ProductList>(context, listen: false)
                          .removeProduct(product);
                    }
                  } on HttpException catch (error) {
                    msg.showSnackBar(SnackBar(content: Text(error.toString())));
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
