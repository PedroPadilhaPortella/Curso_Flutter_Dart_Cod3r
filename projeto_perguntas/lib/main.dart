import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(new PerguntaApp());

class PerguntaApp extends StatelessWidget {
  void responder() {
    print("Pergunta respondida");
  }

  void Function() callback() {
    return () {
      print("callback da resposta");
    };
  }

  @override
  Widget build(BuildContext context) {
    final List<String> perguntas = [
      "Qual sua cor favorita?",
      "Qual o primeiro presidente do brasil?",
    ];
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text("Projeto Perguntas")),
      body: Column(
        children: [
          Text(perguntas[0]),
          ElevatedButton(onPressed: responder, child: Text("Resposta: Azul")),
          ElevatedButton(
              onPressed: callback(), child: Text("Resposta: Laranja")),
        ],
      ),
    ));
  }
}
