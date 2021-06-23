main() {
  String nome = 'Pedro';
  String status = 'Aprovado';
  double nota = 9.6;
  String materia = 'Banco de Dados';

  String frase = "$nome está $status com uma nota de $nota em $materia";

  /*String frase = nome +
      ' está ' +
      status +
      ' com uma nota de ' +
      nota.toString() +
      ' em ' +
      materia;
  */

  print(frase);

  print('Eu tenho \$10,00 reais');
  print('1 + 1 = ${1 + 1}');
}
