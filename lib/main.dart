
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tela_login.dart';
import 'tela_lista_contatos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? usernameToken = prefs.getString('username_token');

  runApp(MyApp(isLoggedIn: usernameToken != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: isLoggedIn ? '/listagem' : '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/listagem': (context) => ListagemPage(),
      },
    );
  }
}
