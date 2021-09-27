import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  final void Function() reiniciarQuestionario;

  Resultado(this.pontuacao, this.reiniciarQuestionario);

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            fraseResultado,
            style: TextStyle(fontSize: 28),
          ),
        ),
        ElevatedButton(
            child: Text(
              'Reiniciar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onPressed: reiniciarQuestionario)
      ],
    );
  }
}
