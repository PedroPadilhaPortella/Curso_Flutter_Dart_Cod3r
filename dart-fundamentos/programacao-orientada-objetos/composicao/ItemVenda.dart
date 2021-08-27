import 'Produto.dart';

class ItemVenda {
  late int quantidade;
  late double _preco;
  late Produto produto;

  ItemVenda(this.produto, {this.quantidade = 1});

  double get preco {
    this._preco = produto.precoComDesconto * this.quantidade;
    return _preco;
  }

  void set preco(double preco) {
    if (preco >= 0) {
      this._preco = preco;
    }
  }
}
