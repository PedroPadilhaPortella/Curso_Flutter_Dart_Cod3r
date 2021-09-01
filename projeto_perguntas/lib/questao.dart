import 'package:flutter/material.dart';

class Questao extends StatelessWidget {
  final String texto;

  Questao({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        texto,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
      width: double.infinity,
      margin: EdgeInsets.all(10),
    );
  }
}
