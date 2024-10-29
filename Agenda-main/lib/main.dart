import 'package:flutter/material.dart';
import 'tela_lista_contatos.dart';

void main() {
  runApp(const AppContatos());
}

class AppContatos extends StatelessWidget {
  const AppContatos({super.key});

  @override
  Widget build(BuildContext context) {
    // Constrói a interface do aplicativo usando o MaterialApp.
    return MaterialApp(
      home:
          const TelaListaContatos(), // Define a tela inicial do aplicativo como TelaListaContatos.
      theme: ThemeData(primarySwatch: Colors.blue), // Define o tema
    );
  }
}
