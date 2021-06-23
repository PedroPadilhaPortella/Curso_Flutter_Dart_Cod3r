import 'dart:io';

main() {
  /* A diferença entre const e final é que a const é definida
   em tempo de compilação, enquanto final é 
   definida em tempo de runtime. */

  // Area da Circunferencia = PI * raio * raio
  const PI = 3.14159;

  stdout.write('Entre com o raio: ');
  final double raio = double.parse(stdin.readLineSync()!);
  final double area = PI * raio * raio;
  print('Area: ' + area.toString());

  /* constantes de estruturas como listas não podem ser alteradas,
   mas elementos podem ser alterados, adicionados e removidos
   sem problemas, a não ser que o valor dessa estrutura seja
   marcado como uma constante*/

  final lista = ['pedro', 'daniel', 'samuel', 'bunhak'];
  // lista = []; //não pode ser atribuído novo valor;
  lista.add('joao');
  lista.remove('bunhak');
  print(lista);

  // const cargos = ['gerente', 'diretor', 'administrador'];
  final cargos = const ['gerente', 'diretor', 'administrador'];
  // cargos = null;  //não pode ser atribuído novo valor;
  // cargos.add('funcionario'); // não pode alterar o conteúdo
  // cargos.remove('administrador');
  print(cargos);

  var frutas = const ['banana', 'maca', 'pera'];
  frutas = ['uva', 'ameixa', 'abacate'];
  // cargos.add('funcionario'); // não pode alterar o conteúdo
  // cargos.remove('administrador');
  print(frutas);
}
