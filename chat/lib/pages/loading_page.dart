import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 10),
          Text(
            'Carregando...',
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryTextTheme.headline6?.color),
          ),
        ],
      )),
    );
  }
}
