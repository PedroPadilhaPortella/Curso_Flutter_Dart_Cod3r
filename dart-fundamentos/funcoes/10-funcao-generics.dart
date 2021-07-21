Object secondV1(List lista) {
  return lista.length >= 2 ? lista[1] : null;
}

E secondV2<E>(List<E> lista) {
  return lista.length >= 2 ? lista[1] : null as E;
}

main() {
  var list = [10, 5, 2, 121, 53, 1, 90, 0];
  print(secondV1(list));
  print(secondV2<int>(list));
}
