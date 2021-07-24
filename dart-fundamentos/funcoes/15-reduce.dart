double somar(double accumulator, double value) {
  return accumulator + value;
}

main() {
  List<double> compras = [10.94, 5.34, 1.99, 14.12, 65.12, 0.75, 22.45];
  double total = compras.reduce(somar);
  print("O total das compras do mercado foi R\$ ${total.roundToDouble()}");

  var notas = [5.5, 10.0, 7.6, 9.3, 8.1, 6.0, 6.3, 4.1, 4.7];
  double media = notas.reduce((total, nota) => total += nota) / notas.length;
  print("\nMédia das notas: ${media.roundToDouble()}");
}
