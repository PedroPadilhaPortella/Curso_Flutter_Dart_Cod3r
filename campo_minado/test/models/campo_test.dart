import 'package:campo_minado/models/campo.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Campo', () {
    test('Abrir campo com explosão', () {
      Campo campo = Campo(linha: 0, coluna: 0);
      campo.minar();
      expect(campo.abrir, throwsException);
    });

    test('Abrir campo sem explosão', () {
      Campo campo = Campo(linha: 0, coluna: 0);
      campo.abrir();
      expect(campo.aberto, isTrue);
    });

    test('Adicionar campo vizinho', () {
      Campo campo = Campo(linha: 3, coluna: 3);

      List<Campo> vizinhos = [
        Campo(linha: 2, coluna: 2),
        Campo(linha: 2, coluna: 3),
        Campo(linha: 2, coluna: 4),
        Campo(linha: 3, coluna: 2),
        Campo(linha: 3, coluna: 4),
        Campo(linha: 4, coluna: 2),
        Campo(linha: 4, coluna: 3),
        Campo(linha: 4, coluna: 4),
        //not neighbors
        Campo(linha: 5, coluna: 5),
        Campo(linha: 5, coluna: 4),
        Campo(linha: 1, coluna: 1),
      ];

      vizinhos.forEach((vizinho) {
        campo.adicionarVizinho(vizinho);
      });

      expect(campo.vizinhos.length, 8);
    });

    test('Adicionar campo não vizinho', () {
      Campo campo1 = Campo(linha: 0, coluna: 0);
      Campo campo2 = Campo(linha: 1, coluna: 3);
      campo1.adicionarVizinho(campo2);
      expect(campo1.vizinhos.isEmpty, isTrue);
    });

    test('Adicionar campo minado', () {
      Campo campo1 = Campo(linha: 2, coluna: 2);
      Campo campo2 = Campo(linha: 1, coluna: 1);
      Campo campo3 = Campo(linha: 2, coluna: 3);
      campo2.minar();
      campo3.minar();
      campo1.adicionarVizinho(campo2);
      campo1.adicionarVizinho(campo3);

      expect(campo1.vizinhos.length, 2);
      expect(campo1.vizinhancaSegura, isFalse);
      expect(campo1.quantidadeMinasNaVizinhanca, 2);
    });
  });
}
