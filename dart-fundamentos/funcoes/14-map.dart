main() {
  var alunos = [
    {'nome': 'Pedro Portella', 'nota': 10},
    {'nome': 'Gabriel Bunhak', 'nota': 8.0},
    {'nome': 'Paulo Abramov', 'nota': 7.5},
    {'nome': 'Pedro Brugnerotto', 'nota': 10.0},
    {'nome': 'Yahn Lima', 'nota': 4.5},
    {'nome': 'João Casalli', 'nota': 8.0},
  ];

  String Function(Map) getNome = (aluno) => aluno['nome'];
  int Function(String) nomeLength = (texto) => texto.length;

  var nomes = alunos.map(getNome);
  var comprimento = nomes.map(nomeLength);

  print(nomes);
  print(comprimento);
}
