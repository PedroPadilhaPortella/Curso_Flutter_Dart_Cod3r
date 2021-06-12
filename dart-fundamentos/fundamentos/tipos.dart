/*
  -List (indexada, repete elemtentos)
  -Set (não indexada e não repete elementos)
  -Map (chave - valor, não repete chaves)
*/

main() {
  List<String> alunos = ['Pedro', 'João', 'Vinicius', 'Gabriel', 'Dieffany'];
  print({alunos, alunos.runtimeType, alunos.length});
  print(alunos.elementAt(1));
  print(alunos[4]);

  Set<String> times = {
    'vasco',
    'flamengo',
    'são paulo',
    'internacional',
    'palmeiras'
  };
  print(times.add('corinthians'));
  print(times.remove('vasco'));
  print({times, times.runtimeType, times.length});
  print(times.contains('vasco'));
  print({times.first, times.last});

  Map<String, String> telefones = {
    'Pedro': '1194832428',
    'João': '8478482481',
    'Vinicius': '11849348931'
  };
  print({telefones, telefones.runtimeType, telefones.length});
  print(telefones['Pedro']);
  print(telefones.keys);
  print(telefones.values);
  print(telefones.entries);

  // List<Object> generica = [1, 1.1, true, 'teste', {}];
  List generica = [1, 1.1, true, 'teste', {}];
  print({generica, generica.runtimeType});
}
