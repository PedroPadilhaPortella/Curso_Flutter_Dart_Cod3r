main() {
  print(concatenar('é só ', 'um teste'));
  print(concatenar('é só ', ' 1'));
}

/* Quando não definimos um tipo para os parametros, 
  ele deixa como um tipo dinâmico.
*/

// dynamic concatenar(dynamic a, dynamic b) {
String concatenar(a, b) {
  return (a.toString() + b.toString());
}
