import 'dart:math';

import 'package:flutter/foundation.dart';

import 'campo.dart';
import 'explosao_exception.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int quantidadeBombas;
  final List<Campo> _campos = [];

  Tabuleiro({
    @required this.linhas,
    @required this.colunas,
    @required this.quantidadeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  bool get resolvido => _campos.every((campo) => campo.resolvido);

  List<Campo> get campos => _campos;

  void _criarCampos() {
    for (int l = 0; l < linhas; l++) {
      for (int c = 0; c < colunas; c++) {
        _campos.add(Campo(linha: l, coluna: c));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (quantidadeBombas > linhas * colunas) {
      throw QuantidadeDeBombasMaiorQueQuantidadeDeCamposException();
    }
    // if (quantidadeBombas > linhas * colunas) return;

    while (sorteadas < quantidadeBombas) {
      int i = Random().nextInt(_campos.length);
      if (!_campos[i].minado) {
        _campos[i].minar();
        sorteadas++;
      }
    }
  }

  void revelarBombas() {
    _campos.forEach((campo) => campo.revelarBomba());
  }

  void reiniciar() {
    _campos.forEach((campo) => campo.reiniciar());
    _sortearMinas();
  }
}
