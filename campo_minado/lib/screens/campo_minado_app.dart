import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

import '../models/explosao_exception.dart';

class CampoMinadoApp extends StatelessWidget {
  CampoMinadoApp({super.key});

  void _reiniciar() {
    print("RESTART");
  }

  void _abrir(Campo campo) {
    print("ABRIR");
  }

  void _alterarMarcacao(Campo campo) {
    print("alterar");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(venceu: false, onRestart: _reiniciar),
        body: Container(
          child: TabuleiroWidget(
            tabuleiro: Tabuleiro(linhas: 3, colunas: 3, quantidadeBombas: 0),
            onOpen: _abrir,
            onUpdateMarkup: _alterarMarcacao,
          ),
        ),
      ),
    );
  }
}
