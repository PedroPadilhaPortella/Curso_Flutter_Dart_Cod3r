class HttpException implements Exception {
  final String mensagem;
  final int statusCode;

  HttpException({required this.mensagem, required this.statusCode});

  @override
  String toString() {
    return mensagem;
  }
}
