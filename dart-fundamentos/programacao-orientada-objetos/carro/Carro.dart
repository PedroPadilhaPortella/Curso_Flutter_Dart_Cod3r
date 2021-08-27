class Carro {
  //Atributos
  late int velocidadeMaxima;
  late int _velocidadeAtual = 0; // privat

//Construtores
  Carro(int velocidadeMaxima) {
    this.velocidadeMaxima = velocidadeMaxima;
  }

  Carro.ctor([this.velocidadeMaxima = 200]);

// Getters e Setters
  int get velocidadeAtual {
    return this._velocidadeAtual;
  }

  void set velocidadeAtual(int velocidade) {
    if (_velocidadeAtual + velocidade < velocidadeMaxima && velocidade > 0) {
      this._velocidadeAtual = velocidade;
    }
  }

// Métodos
  int acelerar() {
    _velocidadeAtual = _velocidadeAtual + 10 >= velocidadeMaxima
        ? velocidadeMaxima
        : _velocidadeAtual + 10;
    return _velocidadeAtual;
  }

  int frear() {
    _velocidadeAtual = _velocidadeAtual - 10 <= 0 ? 0 : _velocidadeAtual - 10;
    return _velocidadeAtual;
  }

  bool estaNoLimite() {
    return _velocidadeAtual == velocidadeMaxima;
  }

  bool estaParado() {
    return _velocidadeAtual == 0;
  }
}
