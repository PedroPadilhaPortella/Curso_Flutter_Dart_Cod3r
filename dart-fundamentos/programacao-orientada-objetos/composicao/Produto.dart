class Produto {
  late int codigo;
  late String nome;
  late double preco;
  late double desconto;

  Produto(
      {required this.codigo,
      required this.nome,
      required this.preco,
      required this.desconto});

  Produto.common(this.codigo, this.nome, this.preco, this.desconto);

  double get precoComDesconto {
    return (1 - desconto) * this.preco;
  }
}
