import 'dart:io';

main() {
  // ForIn com Listas
  List<String> frutas = ['banana', 'maçã', 'uva', 'abacaxi', 'pera'];
  for (var fruta in frutas) {
    stdout.write('$fruta, ');
  }

  //For dentro de outro for
  print("\n\nCoordenadas");
  List<List<int>> coordenadas = [
    [1, 2],
    [1, 4],
    [8, 2],
    [8, 4]
  ];

  for (var coordenada in coordenadas) {
    for (var ponto in coordenada) {
      stdout.write('$ponto,');
    }
    print('');
  }
}
