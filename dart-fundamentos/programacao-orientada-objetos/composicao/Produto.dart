class Produto {
  late int codigo;
  late String nome;
  late double preco;
  late double desconto;

  Produto(this.codigo, this.nome, this.preco, this.desconto);

  double get precoComDesconto {
    return (1 - desconto) * this.preco;
  }
}
