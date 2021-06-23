// Operadores em Dart

main() {
  // Aritmeticos
  print('        Operadores Aritméticos');
  print(6 + 4);
  print(10 - 8);
  print(7 * 4);
  print(18 / 3);
  print(11 % 4);

  // Lógicos
  print('        Operadores Lógicos');
  bool fragile = true;
  bool expensive = false;
  print(fragile && expensive); // E
  // ignore: dead_code
  print(fragile || expensive); // OU
  print(fragile ^ expensive); // XOR, OU EXCLUSIVO, 'ou um ... , ou outro ...'
  print(!fragile); // NOT
  print(!!expensive); // NOT NOT

  // Atribuição
  print('        Operadores de Atribuição');
  double a = 0;
  print(a++); //0
  print(++a); //2
  print(a--); //2
  print(--a); //0
  a += 10; //a = a + 10;
  print(a); //10
  a -= 2; //a = a - 2;
  print(a); //8
  a /= 2; //a = a / 2;
  print(a); //4
  a *= 5; //a = a * 5;
  print(a); //20
  a %= 2; //a = a % 2;
  print(a); //0

  // Relacionais
  print('        Operadores Relacionais');
  print(3 > 2);
  print(3 >= 3);
  print(3 != 3);
  print(3 == '3');
  print(3 == int.parse('3'));
  print(5 & 4);
}
