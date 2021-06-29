import 'dart:math';

main() {
  print('O numero sorteado foi ${sortear(100, 60)}');
  print('O numero sorteado foi ${sortear(25)}');
  print('O numero sorteado foi ${sortear()}');

  imprimirData(1993, 19, 05);
  imprimirData(2001, 10, 06);
  imprimirData(2020);
}

/* Parametros Opcionais */

int sortear([int maximo = 42, int minimo = 0]) {
  return Random().nextInt(maximo);
}

void imprimirData(int ano, [int dia = 1, int mes = 1]) {
  print('$dia/$mes/$ano');
}
