main() {
  //Tipos primivos
  int a = 10;
  double b = 3.14159;
  String c = 'pedro';
  bool d = true;
  print({a, b, c, d});

  //Concatenação
  var text = 'A Soma é ';
  var n1 = 100;
  var n2 = 100;
  print(text + (n1 + n2).toString());

  //tipo da variavel
  print(a.runtimeType);
  print(b.runtimeType);
  print(c.runtimeType);
  print(d.runtimeType);

  //Tipo Dynamic
  dynamic dinamica = 'tipo dinamico';
  print(dinamica);
  dinamica = 10010011;
  print(dinamica);
}
