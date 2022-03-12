import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  static const _url = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const _key = '?key=AIzaSyDOu3-UJfFY_N0BPwFtUC3UUCueG8a9nok';

  static const endpoints = {
    'signup': 'accounts:signUp',
    'signin': 'signInWithPassword'
  };

  String? _token;
  String? _email;
  String? _uid;
  DateTime? _espiresDate;

  bool get isAuth {
    final isValid = _espiresDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token => isAuth ? _token : null;

  String? get email => isAuth ? _email : null;

  String? get uid => isAuth ? _uid : null;

  Future<void> register(String email, String password) async {
    final response = await http.post(
      Uri.parse("$_url${endpoints['signup']}$_key"),
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

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$_url${endpoints['signin']}$_key"),
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
