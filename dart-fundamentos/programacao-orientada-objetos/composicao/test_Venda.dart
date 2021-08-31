import 'Cliente.dart';
import 'Produto.dart';
import 'Venda.dart';
import 'ItemVenda.dart';

main(List<String> args) {
  Cliente cliente = new Cliente.common("Pedro P Portella", "46723467400");

  Produto prod1 = new Produto.common(1001, "Macbook Pro", 22000, 0.2);
  Produto prod2 = new Produto.common(1002, "Mouse Razor", 89.99, 0.5);
  Produto prod3 =
      new Produto.common(1003, "Fone de Ouvido Bluetooth Xiaomi", 99.99, 0);

  ItemVenda item1 = new ItemVenda.common(prod1);
  ItemVenda item2 = new ItemVenda.common(prod2, quantidade: 2);
  ItemVenda item3 = new ItemVenda.common(prod3);

  Venda venda1 = new Venda.common(cliente, items: [item1, item2, item3]);

  print(venda1);

  var venda2 = Venda(
      cliente: Cliente(nome: 'Francisco Cardoso', cpf: '123.456.789-00'),
      items: <ItemVenda>[
        ItemVenda(
          quantidade: 5,
          produto: Produto(
              codigo: 2001, nome: "Caneta Bic", preco: 5.8, desconto: 0.5),
        ),
        ItemVenda(
          quantidade: 8,
          produto: Produto(
              codigo: 2002,
              nome: "Caderno Espiral",
              preco: 12.50,
              desconto: 0.2),
        ),
        ItemVenda(
          quantidade: 100,
          produto:
              Produto(codigo: 2003, nome: "Coxinha", preco: 1, desconto: 0),
        ),
      ]);

  print(venda2);
  print(venda2.total);
}
