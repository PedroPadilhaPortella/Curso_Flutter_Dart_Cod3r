import 'dart:io';

main() {
  String digitado = '';
  do {
    stdout.write('Digite algo ou "sair" para sair:');
    digitado = stdin.readLineSync().toString();
    print('$digitado');
  } while (digitado != 'sair');
}
