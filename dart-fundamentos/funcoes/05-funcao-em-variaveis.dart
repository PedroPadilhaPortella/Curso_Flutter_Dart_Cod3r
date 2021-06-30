import 'dart:math';

main() {
  /* Arrow Function */
  int Function(int, int) soma = (a, b) => a + b;

  /* Função Anônima */
  var potencia = powFn;

  int resultado = soma(10, 9);
  print(resultado);
  print('4 ^ 2 = ${potencia(4, 2)}');
}

num powFn(int base, int expoente) {
  return pow(base, expoente);
}
