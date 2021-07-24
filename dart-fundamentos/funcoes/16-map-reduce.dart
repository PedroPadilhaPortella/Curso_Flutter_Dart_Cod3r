double Function(Map) getNota = (aluno) => aluno['nota'];
double somaNotas(double soma, double nota) => soma += nota;

main() {
  var alunos = [
    {'nome': 'Pedro Portella', 'nota': 10.0},
    {'nome': 'Gabriel Bunhak', 'nota': 8.0},
    {'nome': 'Paulo Abramov', 'nota': 7.5},
    {'nome': 'Pedro Brugnerotto', 'nota': 10.0},
    {'nome': 'Yahn Lima', 'nota': 4.5},
    {'nome': 'João Casalli', 'nota': 8.0},
  ];

  var media = alunos
          .map((aluno) => aluno['nota'] as double)
          .reduce((total, nota) => total += nota) /
      alunos.length;

  media = alunos.map(getNota).reduce(somaNotas) / alunos.length;

  print("\nMédia das notas: $media");
}
