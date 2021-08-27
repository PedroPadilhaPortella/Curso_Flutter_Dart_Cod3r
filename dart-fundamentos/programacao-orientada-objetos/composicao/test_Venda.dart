import 'Cliente.dart';
import 'Produto.dart';
import 'Venda.dart';
import 'ItemVenda.dart';

main(List<String> args) {
  Cliente cliente = new Cliente("Pedro P Portella", "46723467400");

  Produto prod1 = new Produto(1001, "Macbook Pro", 22000, 0.2);
  Produto prod2 = new Produto(1002, "Mouse Razor", 89.99, 0.5);
  Produto prod3 =
      new Produto(1003, "Fone de Ouvido Bluetooth Xiaomi", 99.99, 0);

  ItemVenda item1 = new ItemVenda(prod1);
  ItemVenda item2 = new ItemVenda(prod2, quantidade: 2);
  ItemVenda item3 = new ItemVenda(prod3);

  Venda venda = new Venda(cliente, items: [item1, item2, item3]);

  print(venda);
}
