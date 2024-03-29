import 'package:flutter/material.dart';

class CronometroButton extends StatelessWidget {
  final String texto;
  final IconData icone;
  final void Function()? click;

  const CronometroButton({
    Key? key,
    required this.texto,
    required this.icone,
    this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        textStyle: const TextStyle(fontSize: 25),
      ),
      onPressed: click,
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            icone,
            size: 30,
          ),
        ),
        Text(texto),
      ]),
    );
  }
}
