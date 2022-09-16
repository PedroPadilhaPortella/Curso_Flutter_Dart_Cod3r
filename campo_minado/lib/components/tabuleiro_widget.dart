import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

import '../models/campo.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(Campo) onOpen;
  final void Function(Campo) onUpdateMarkup;

  TabuleiroWidget({
    required this.tabuleiro,
    required this.onOpen,
    required this.onUpdateMarkup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: tabuleiro.colunas,
        children: tabuleiro.campos.map((campo) {
          return CampoWidget(
            campo: campo,
            onOpen: onOpen,
            onUpdateMarkup: onUpdateMarkup,
          );
        }).toList(),
      ),
    );
  }
}
