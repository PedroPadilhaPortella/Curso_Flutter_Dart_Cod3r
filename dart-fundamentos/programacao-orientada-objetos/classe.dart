class Data {
  late int dia;
  late int mes;
  late int ano;

  //Construtor
  Data([this.dia = 1, this.mes = 1, this.ano = 1970]);

  //Construtor nomeado Padrão do Java/C#,
  Data.padrao(int dia, int mes, int ano) {
    this.dia = dia;
    this.mes = mes;
    this.ano = ano;
  }

  //Construtor nomeado
  Data.com({this.dia = 1, this.mes = 1, this.ano = 1970});

  //Construtor nomeado Ultimo dia do ano
  Data.ultimoDiaDoAno(int ano) {
    this.dia = 31;
    this.mes = 12;
    this.ano = ano;
  }

  String dataFormatada() {
    return "${this.dia}/${this.mes}/${this.ano}";
  }

  //Metodo ToString
  String toString() {
    return this.dataFormatada();
  }
}

main(List<String> args) {
  Data dataNascimento = new Data(10, 06, 2001);
  print("Data de Nascimento: $dataNascimento");

  print("Data com Construtor Nomeado ${new Data.padrao(19, 6, 2020)}");
  print("Data com Construtor Nomeado ${new Data.com(ano: 2020)}");
  print("Ultimo dia do Ano: ${new Data.com(ano: 2029)}");
}
