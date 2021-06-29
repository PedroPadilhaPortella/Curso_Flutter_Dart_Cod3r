/*  Funções em Dart  */

main() {
  double a = 2;
  double b = 4;

  print(soma(a, b));
  print(subtracao(a, b));
  print(divisao(b, a));
  print(produto(10, 9));
}

String soma(double a, double b) {
  return "A soma de $a e $b é de ${a + b}";
}

String subtracao(double a, double b) {
  return "A subtracao de $a e $b é de ${a - b}";
}

String divisao(double a, double b) {
  return "A divisao de $a por $b é de ${a / b}";
}

String produto(double a, double b) {
  return "O produto de $a e $b é de ${a * b}";
}
