import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';
import 'package:shop/utils/exceptions/auth_exception.dart';

/// Provider de Autenticação
class Auth with ChangeNotifier {
  static const _key = '?key=AIzaSyDOu3-UJfFY_N0BPwFtUC3UUCueG8a9nok';

  static const endpoints = {
    'signup': 'accounts:signUp',
    'signin': 'signInWithPassword'
  };

  String? _token;
  String? _email;
  String? _uid;
  DateTime? _espiresDate;

  /// Método resposável por checar se o usuário está autenticado
  bool get isAuth {
    final isValid = _espiresDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  /// Método resposável por retornar o token
  String? get token => isAuth ? _token : null;

  /// Método resposável por retornar o email
  String? get email => isAuth ? _email : null;

  /// Método resposável por retornar o uid
  String? get uid => isAuth ? _uid : null;

  /// Método resposável por registrar um novo usuário
  Future<void> register(String email, String password) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrlAuth}${endpoints['signup']}$_key"),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['uid'];
      _espiresDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      notifyListeners();
    }
  }

  /// Método resposável por fazer por login de um usuário
  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrlAuth}${endpoints['signin']}$_key"),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['uid'];
      _espiresDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      notifyListeners();
    }
  }
}
