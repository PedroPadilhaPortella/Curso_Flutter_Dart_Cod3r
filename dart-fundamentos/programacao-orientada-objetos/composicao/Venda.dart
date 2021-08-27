import 'Cliente.dart';
import 'ItemVenda.dart';

class Venda {
  late Cliente cliente;
  late List<ItemVenda> items;

  Venda(this.cliente, {this.items = const []});

  double get total {
    double total = items
        .map((item) => item.preco * item.quantidade)
        .reduce((total, item) => total + item);

    return total;
  }

  String toString() {
    String stringBuilder =
        "Cliente: ${cliente.nome}, ${cliente.cpf} \nProdutos:";
    for (var item in items) {
      stringBuilder +=
          "\n\t ${item.produto.codigo} - ${item.produto.nome} / Preço: R\$ ${item.produto.preco}, Quantidade: ${item.quantidade} = Subtotal: R\$ ${item.preco}";
    }

    stringBuilder += "\n\t\t\t\t Total = R\$ ${this.total}";

    return stringBuilder;
  }
}
