import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexible & Expanded',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flexible & Expanded'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 100,
            child: Text('Item 1 - pretty big!'),
            color: Colors.red,
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              child: Text('Item 2'),
              color: Colors.blue,
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              height: 100,
              child: Text('Item 3'),
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
