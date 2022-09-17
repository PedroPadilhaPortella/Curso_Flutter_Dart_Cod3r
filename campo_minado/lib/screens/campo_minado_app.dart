import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

import '../enums/status.dart';

class CampoMinadoApp extends StatefulWidget {
  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  Tabuleiro _tabuleiro;
  Status _status = Status.jogando;

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(
        linhas: qtdeLinhas,
        colunas: qtdeColunas,
        quantidadeBombas: 50,
      );
    }
    return _tabuleiro;
  }

  void _reiniciar() {
    setState(() {
      _status = Status.jogando;
      _tabuleiro.reiniciar();
    });
  }

  void _abrir(Campo campo) {
    if (_status != Status.jogando) return;

    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro.resolvido) {
          _status = Status.venceu;
        }
      } on ExplosaoException {
        _status = Status.perdeu;
        _tabuleiro.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (_status != Status.jogando) return;

    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro.resolvido) {
        _status = Status.venceu;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultadoWidget(status: _status, onRestart: _reiniciar),
        body: Container(
            color: Colors.grey,
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return TabuleiroWidget(
                  tabuleiro: _getTabuleiro(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  ),
                  onOpen: _abrir,
                  onUpdateMarkup: _alternarMarcacao,
                );
              },
            )),
      ),
    );
  }
}
