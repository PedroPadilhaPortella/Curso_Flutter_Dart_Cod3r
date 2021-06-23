import 'dart:io';

main() {
  String digitado = '';

  while (digitado != 'sair') {
    stdout.write('Digite algo ou "sair" para sair:');
    digitado = stdin.readLineSync().toString();
    print('$digitado');
  }
  print('Saindo...');

  // usando for
  digitado = '';

  for (; digitado != 'sair';) {
    stdout.write('Digite algo ou "sair" para sair:');
    digitado = stdin.readLineSync().toString();
    print('$digitado');
  }
  print('Saindo...');
}
