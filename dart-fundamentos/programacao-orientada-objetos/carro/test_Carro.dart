import 'Carro.dart';

main(List<String> args) {
  Carro mercedes = new Carro.ctor(125);

  while (!mercedes.estaNoLimite()) {
    print(mercedes.acelerar());
  }

  // print("velocidade atual: ${mercedes.velocidadeAtual}"); // private
  print("velocidade atual: ${mercedes.velocidadeAtual}");
  mercedes.velocidadeAtual = 500;

  while (!mercedes.estaParado()) {
    print(mercedes.frear());
  }
}
