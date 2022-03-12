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
    }

    print(jsonDecode(response.body));
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
    }

    print(jsonDecode(response.body));
  }
}
