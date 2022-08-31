import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(AuthFormData) onSubmit;

  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authForm = new AuthFormData();

  void _handleImagePick(File image) {
    _authForm.image = image;
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    // TODO deixar a seleção de imagem opcional
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_authForm.image == null && _authForm.isRegister) {
      return _showError('Imagem não selecionada.');
    }
    widget.onSubmit(_authForm);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_authForm.isRegister)
                  UserImagePicker(onImagePick: _handleImagePick),
                if (_authForm.isRegister)
                  TextFormField(
                    key: ValueKey('name'),
                    initialValue: _authForm.name,
                    decoration: InputDecoration(labelText: 'Nome'),
                    onChanged: (name) => _authForm.name = name,
                    validator: (_name) {
                      final name = _name ?? '';
                      if (name.trim().length < 3) {
                        return 'O nome precisa ter ao menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  key: ValueKey('email'),
                  initialValue: _authForm.email,
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (email) => _authForm.email = email,
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().length < 5 || !email.contains('@')) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  key: ValueKey('password'),
                  initialValue: _authForm.password,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Senha'),
                  onChanged: (password) => _authForm.password = password,
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.length < 6) {
                      return 'A senha precisa ter ao menos 6 carateres';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_authForm.isLogin ? 'Entrar' : 'Cadastrar'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _authForm.toggleMode();
                    });
                  },
                  child: Text(_authForm.isLogin
                      ? 'Ainda não possui uma conta?'
                      : 'Já possui uma conta?'),
                ),
              ],
            )),
      ),
    );
  }
}
