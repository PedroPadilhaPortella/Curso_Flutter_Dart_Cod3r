import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _sum = 0;
  int _a = 0;
  int _b = 0;

  Future<void> calculateSum() async {
    const channel = MethodChannel('cod3r.com.br/nativo');
    try {
      final resultado = await channel.invokeMethod(
        'calculateSum',
        {'a': _a, 'b': _b},
      );
      setState(() {
        _sum = resultado;
      });
    } on PlatformException catch (e) {
      setState(() {
        _sum = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nativo'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Soma = ${_sum}',
                style: TextStyle(fontSize: 30),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _a = int.tryParse(value) ?? 0;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _b = int.tryParse(value) ?? 0;
                  });
                },
              ),
              ElevatedButton(
                child: Text('Calcular'),
                onPressed: calculateSum,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
