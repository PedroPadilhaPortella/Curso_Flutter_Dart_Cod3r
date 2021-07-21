bool Function(double) notasGreaterThan6 = (double nota) => nota >= 6;
bool Function(double) notasGreaterThan8 = (double nota) => nota >= 8;
bool Function(double) notasLessThan6 = (double nota) => nota < 6;

main() {
  var notas = [5.5, 10.0, 7.6, 9.3, 8.1, 6.0, 6.3, 4.1, 4.7];

  var aprovado = notas.where(notasGreaterThan6);
  var mural = notas.where(notasGreaterThan8);
  var reprovado = notas.where(notasLessThan6);

  print("Reprovados: $reprovado");
  print("Aprovados: $aprovado");
  print("Mural: $mural");
}
