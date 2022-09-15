import 'package:campo_minado/components/resultado_widget.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatelessWidget {
  const CampoMinadoApp({super.key});

  void _reiniciar() {
    print("RESTART");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(venceu: false, onRestart: _reiniciar),
        body: Container(
          child: Text('tabuleiro'),
        ),
      ),
    );
  }
}
