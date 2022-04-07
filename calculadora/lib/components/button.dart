import 'dart:ffi';

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color.fromRGBO(82, 82, 82, 1);
  static const DEFAULT = Color.fromRGBO(112, 112, 112, 1);
  static const OPERATION = Color.fromRGBO(250, 158, 13, 1);

  final String text;
  final bool doubleButton;
  final Color color;
  final void Function(String) cb;

  Button({
    Key? key,
    required this.text,
    this.doubleButton = false,
    this.color = DEFAULT,
    required this.cb,
  }) : super(key: key);

  Button.doubleButton({
    Key? key,
    required this.text,
    this.doubleButton = true,
    this.color = DEFAULT,
    required this.cb,
  }) : super(key: key);

  Button.operation({
    Key? key,
    required this.text,
    this.doubleButton = false,
    this.color = OPERATION,
    required this.cb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: doubleButton ? 2 : 1,
      child: ElevatedButton(
        onPressed: () => cb(text),
        style: ElevatedButton.styleFrom(primary: color),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
