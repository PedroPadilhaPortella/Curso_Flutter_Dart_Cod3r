main() {
  imprimirData(dia: 10, mes: 06, ano: 2022);
  imprimirData(dia: 12, ano: 2009);
  imprimirData(ano: 1945);
  imprimirData();
}

/* Parametros Nomeados */

void imprimirData({int dia = 1, int mes = 1, int ano = 1970}) {
  print('$dia/$mes/$ano');
}
