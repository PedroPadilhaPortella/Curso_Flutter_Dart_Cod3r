import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Classe responável por gerenciar os dados salvos em SharedPreferences
class Store {
  /// Método responsável por salvar um objeto chave:valor no SharedPreferences
  static Future<bool> saveString(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  /// Método responsável por salvar um Map nas SharedPreferences
  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    return saveString(key, jsonEncode(value));
  }

  /// Método responsável por buscar um objeto chave:valor no SharedPreferences
  static Future<String> getString(String key,
      [String defaultValue = '']) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? defaultValue;
  }

  /// Método responsável por buscar um Map nas SharedPreferences
  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      return jsonDecode(await getString(key));
    } catch (_) {
      return {};
    }
  }

  /// Método responsável por remover um objeto chave:valor do SharedPreferences
  static Future<bool> remove(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
