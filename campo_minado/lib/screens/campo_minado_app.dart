import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/models/campo.dart';
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
    print("ABRIR");
  }

  @override
  Widget build(BuildContext context) {
    Campo vizinho1 = Campo(linha: 1, coluna: 0);
    vizinho1.minar();
    Campo vizinho2 = Campo(linha: 1, coluna: 0);
    vizinho2.minar();

    Campo campo = Campo(linha: 0, coluna: 0);
    campo.adicionarVizinho(vizinho1);
    campo.adicionarVizinho(vizinho2);
    campo.abrir();

    try {
      //campo.minar();
      // campo.alternarMarcacao();
    } on ExplosaoException {}

    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(venceu: false, onRestart: _reiniciar),
        body: Container(
          child: CampoWidget(
              campo: campo, onOpen: _abrir, onUpdateMarkup: _alterarMarcacao),
        ),
      ),
    );
  }
}
