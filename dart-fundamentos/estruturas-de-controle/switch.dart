import 'dart:io';

main() {
  String cartao = stdin.readLineSync().toString();
  switch (cartao) {
    case 'Visa':
      print("Você escolheu Visa");
      break;
    case 'MasterCard':
      print("Você escolheu Mastecard");
      break;
    case 'Flash':
      print("Você escolheu Flash Benefícios");
      break;
    case 'Alelo VR':
    case 'Alelo VA':
    case 'Alelo':
      print("Você escolheu Alelo Benefícios");
      break;
    default:
      print("Você escolheu Outro cartão");
  }
}
