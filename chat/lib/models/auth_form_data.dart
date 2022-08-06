import 'dart:io';

enum AuthMode { register, login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.login;

  get isLogin => _mode == AuthMode.login;

  get isRegister => _mode == AuthMode.register;

  void toggleMode() {
    _mode = isLogin ? AuthMode.register : AuthMode.login;
  }
}
