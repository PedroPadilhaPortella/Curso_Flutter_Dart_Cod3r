import 'Cliente.dart';
import 'ItemVenda.dart';

class Venda {
  late Cliente cliente;
  late List<ItemVenda> items;

  Venda({required this.cliente, this.items = const []});

  Venda.common(this.cliente, {this.items = const []});

  double get total {
    double total =
        items.map((item) => item.preco).reduce((total, item) => total + item);

    return total;
  }

  String toString() {
    String stringBuilder =
        "Cliente: ${cliente.nome}, ${cliente.cpf} \nProdutos:";
    for (var item in items) {
      stringBuilder +=
          "\n\t ${item.produto.codigo} - ${item.produto.nome} R\$ ${item.produto.precoComDesconto}, Qtd: ${item.quantidade} = Subtotal: R\$ ${item.preco}";
    }

    stringBuilder += "\n\t\t\t\t Total = R\$ ${this.total}\n\n";

    return stringBuilder;
  }
}
