import 'dart:math';

main() {
  int nota = Random().nextInt(11);
  print(nota);
  if (nota > 6) {
    print('Aprovado');
  } else if (nota >= 5) {
    print('Recuperação');
  } else {
    print('Reprovado');
  }
}
