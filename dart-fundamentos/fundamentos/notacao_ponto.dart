main() {
  double nota = 6.99.roundToDouble();
  print(nota);
  nota = 6.99.truncateToDouble();
  print(nota);

  String texto = '  lower  '.toUpperCase().toLowerCase().trim();
  print(texto);
  texto = texto.substring(0, 3);
  print(texto);
  texto = texto.padRight(10, '_');
  print(texto);
}
