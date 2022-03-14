import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/utils/exceptions/auth_exception.dart';

/// Provider de Autenticação
class Auth with ChangeNotifier {
  static const _key = '?key=AIzaSyDOu3-UJfFY_N0BPwFtUC3UUCueG8a9nok';

  static const endpoints = {'signup': 'signUp', 'signin': 'signInWithPassword'};

  String? _token;
  String? _email;
  String? _userId;
  DateTime? _espiresDate;
  Timer? _logoutTimer;

  /// Método resposável por checar se o usuário está autenticado
  bool get isAuth {
    final isValid = _espiresDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  /// Método resposável por retornar o token
  String? get token => isAuth ? _token : null;

  /// Método resposável por retornar o email
  String? get email => isAuth ? _email : null;

  /// Método resposável por retornar o userId
  String? get userId {
    return isAuth ? _userId : null;
  }

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
      _userId = body['localId'];
      _espiresDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );

      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'userId': _userId,
        'espiresDate': _espiresDate!.toIso8601String()
      });

      _autoLogout();
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
      _userId = body['localId'];
      _espiresDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );

      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'userId': _userId,
        'espiresDate': _espiresDate!.toIso8601String()
      });

      _autoLogout();
      notifyListeners();
    }
  }

  /// Método responsável por tentar realizar um auto login
  /// buscando os dados de token da Store
  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return;

    final espiresDate = DateTime.parse(userData['espiresDate']);
    if (espiresDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _espiresDate = espiresDate;

    _autoLogout();
    notifyListeners();
  }

  /// Método responsável por realizar o logout da aplicação,
  /// limpando todos os dados de sessão e token
  void logout() async {
    _token = null;
    _email = null;
    _userId = null;
    _espiresDate = null;

    await Store.remove('userData');
    _clearLogoutTimer();
    notifyListeners();
  }

  /// Método responsável por realizar o logout da aplicação automaticamente,
  /// baseado no tempo de expiração do firebase
  void _autoLogout() {
    _clearLogoutTimer();
    final time = _espiresDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: time ?? 0), logout);
  }

  /// Método responsável por limpar o timer de logout
  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }
}
