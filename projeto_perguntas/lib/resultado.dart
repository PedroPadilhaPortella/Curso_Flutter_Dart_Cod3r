import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;

  Resultado(this.pontuacao);

  String get fraseResultado {
    String resultado = 'Pontuação: $pontuacao\n';
    if (pontuacao < 8)
      resultado += 'Você é fraco';
    else if (pontuacao < 12)
      resultado += 'Normal';
    else if (pontuacao < 16)
      resultado += 'Nível Superior';
    else
      resultado += 'Jedai!!';
    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        fraseResultado,
        style: TextStyle(fontSize: 28),
      ),
    );
  }
}
