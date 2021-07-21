List<E> filtrar<E>(List<E> lista, bool Function(E) fn) {
  List<E> listaFiltrada = [];

  for (var elemento in lista) {
    if (fn(elemento)) {
      listaFiltrada.add(elemento);
    }
  }
  return listaFiltrada;
}

main() async {
  var notas = [5.5, 10.0, 7.6, 9.3, 8.1, 6.0, 6.3, 4.1, 4.7];

  // var aprovar = (double nota) => nota >= 7;
  var aprovados = filtrar(notas, (double nota) => nota >= 7);
  print(aprovados);

  var alunos = ['Pedro', 'Vitor', 'Lucas', 'Maiki'];
  var nomeMaiorQue5Letras = filtrar(alunos, (String nome) => nome.length >= 5);
  print(nomeMaiorQue5Letras);
}
