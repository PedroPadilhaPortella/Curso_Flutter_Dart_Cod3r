import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/utils/exceptions/auth_exception.dart';

enum AuthMode { Register, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  AnimationController? _animationController;
  Animation<Size>? _heightAnimation;

  final Map<String, String> _authData = {'email': '', 'password': ''};

  bool _isLogging() => _authMode == AuthMode.Login;
  bool _isRegister() => _authMode == AuthMode.Register;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heightAnimation = Tween(
      begin: const Size(double.infinity, 310),
      end: const Size(double.infinity, 400),
    ).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.linear),
    );

    // _heightAnimation?.addListener(() => setState(() {}));
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          )
        ],
      ),
    );
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogging()) {
        _authMode = AuthMode.Register;
        _animationController?.forward();
      } else {
        _authMode = AuthMode.Login;
        _animationController?.reverse();
      }
    });
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isLoading = true);
    _formKey.currentState?.save();

    Auth auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_isLogging()) {
        await auth.login(_authData['email']!, _authData['password']!);
      } else {
        await auth.register(_authData['email']!, _authData['password']!);
      }
    } on AuthException catch (error) {
      showErrorDialog(error.toString());
    } catch (error) {
      showErrorDialog('Ocorreu um erro inesperado.');
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(16.0),
        height: _isLogging() ? 310 : 400,
        // height: _heightAnimation?.value.height ?? (_isLogging() ? 310 : 400),
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  return (email.trim().isEmpty || !email.contains('@'))
                      ? "Informe uma email válido"
                      : null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';
                  return (password.isEmpty || password.length < 6)
                      ? "Informe uma senha válida"
                      : null;
                },
              ),
              if (_isRegister())
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: _isLogging()
                      ? null
                      : (_password) {
                          final password = _password ?? '';
                          return (password != _passwordController.text)
                              ? "Senhas não Conferem"
                              : null;
                        },
                ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isLogging() ? "ENTRAR" : "REGISTRAR"),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
              Spacer(),
              TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(_isLogging()
                      ? 'deseja registrar?'
                      : 'já possui uma conta?')),
            ],
          ),
        ),
      ),
    );
  }
}
