import 'dart:math';

void executar(Function fnPar, Function fnImpar) {
  int sorteado = Random().nextInt(10);
  sorteado % 2 == 0 ? fnPar(sorteado) : fnImpar(sorteado);
}

main() {
  var funcaoPar = (int value) => print('O Valor $value é Par');
  var funcaoImpar = (int value) => print('O Valor $value é Impar');

  executar(funcaoPar, funcaoImpar);
}
