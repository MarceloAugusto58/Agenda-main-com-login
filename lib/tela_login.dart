
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Simulação de verificação de login
    bool loginSuccess = await verificarLogin(username, password);

    if (loginSuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username_token', username);
      Navigator.pushReplacementNamed(context, '/listagem');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Usuário ou senha incorretos"),
      ));
    }
  }

  Future<void> _goToCadastro() async {
    Navigator.pushNamed(context, '/cadastro');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: _goToCadastro,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
