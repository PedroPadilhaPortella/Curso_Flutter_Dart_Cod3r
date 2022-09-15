import 'package:campo_minado/models/explosao_exception.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({
    required this.linha,
    required this.coluna,
  });

  bool get minado => _minado;
  bool get explodido => _explodido;
  bool get aberto => _aberto;
  bool get marcado => _marcado;

  bool get resolvido {
    bool minadoMarcado = minado && marcado;
    bool seguroAberto = !minado && aberto;
    return minadoMarcado && seguroAberto;
  }

  int get quantidadeMinasNaVizinhanca {
    return vizinhos.where((vizinho) => vizinho.minado).length;
  }

  bool get vizinhancaSegura {
    return vizinhos.every((vizinho) => !vizinho.minado);
  }

  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) return;

    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    if (_aberto) return;

    _aberto = true;

    if (_minado) {
      _aberto = true;
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhancaSegura) {
      vizinhos.forEach((vizinho) => vizinho.abrir());
    }
  }

  void revelarBombas() {
    if (_minado) {
      _aberto = true;
    }
  }

  void alternanMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  void minar() {
    _minado = true;
  }
}
