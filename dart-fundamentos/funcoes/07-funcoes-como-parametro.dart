void executarPor(int quantidade, Function(String) fn, String valor) {
  for (var i = 0; i < quantidade; i++) {
    fn(valor);
  }
}

main() {
  executarPor(10, print, 'é só um teste');
}
