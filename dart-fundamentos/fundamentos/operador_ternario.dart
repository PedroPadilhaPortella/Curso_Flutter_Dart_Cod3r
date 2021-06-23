import 'dart:io';

main() {
  // Operador Ternário
  stdout.write('Is it raining? (yes/no)? ');
  final String resposta = stdin.readLineSync() == 'yes'
      ? "\nIt's better carry an umbrella with you"
      : "\nDon't forget yout wallet";
  print(resposta);
}
