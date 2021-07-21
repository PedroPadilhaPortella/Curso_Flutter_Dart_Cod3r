main() {
  var notas = [5.5, 10, 7.6, 9.3, 8.1, 6.0, 6.3, 4.1, 4.7];
  var notasGreaterThan7 = [];

  for (var nota in notas) {
    if (nota >= 7.0) {
      notasGreaterThan7.add(nota);
    }
  }

  print(notasGreaterThan7);
}
