import 'dart:io';

main() {
  // Area da Circunferencia = PI * raio * raio
  const PI = 3.14159;

  stdout.write('Entre com o raio: ');
  final double raio = double.parse(stdin.readLineSync()!);
  final double area = PI * raio * raio;
  print('Area: ' + area.toString());

  /* A diferença entre const e final é que a const é definida
   em tempo de compilação, enquanto final é 
   definida em tempo de runtime. */
}
