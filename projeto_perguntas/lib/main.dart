import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

main() => runApp(new PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var perguntaSelecionada = 0;

  void _responder() {
    setState(() {
      perguntaSelecionada++;
    });
    print(perguntaSelecionada);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> perguntas = [
      "Qual sua cor favorita?",
      "Qual o primeiro presidente do brasil?",
      "8^2?",
      "Qual a linguagem de programação mais usada?",
    ];
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text("Projeto Perguntas")),
      body: Column(
        children: [
          Questao(texto: perguntas[perguntaSelecionada]),
          Resposta(texto: "Resposta A", onSelected: _responder),
          Resposta(texto: "Resposta B", onSelected: _responder),
          Resposta(texto: "Resposta C", onSelected: _responder),
        ],
      ),
    ));
  }
}

class PerguntaApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PerguntaAppState();
  }
}
