class Carro {
  late int velocidadeMaxima;
  late int velocidadeAtual;

  Carro(int velocidadeMaxima) {
    this.velocidadeMaxima = velocidadeMaxima;
    this.velocidadeAtual = 0;
  }

  int acelerar() {
    velocidadeAtual = velocidadeAtual + 10 >= velocidadeMaxima
        ? velocidadeMaxima
        : velocidadeAtual + 10;
    return velocidadeAtual;
  }

  int frear() {
    velocidadeAtual = velocidadeAtual - 10 <= 0 ? 0 : velocidadeAtual - 10;
    return velocidadeAtual;
  }

  bool estaNoLimite() {
    return velocidadeAtual == velocidadeMaxima;
  }
}
