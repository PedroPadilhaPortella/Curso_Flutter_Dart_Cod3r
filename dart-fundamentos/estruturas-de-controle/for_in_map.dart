main() {
  // ForIn em Maps
  Map<String, double> notas = {
    'P H Portella': 10,
    'J Casalli': 9.2,
    'V Brugnerotto': 10,
    'G Bunhak': 8
  };

  print('Aluno            Média');

  for (var aluno in notas.entries) {
    print('${aluno.key} | AVG: ${aluno.value}');
  }
}
