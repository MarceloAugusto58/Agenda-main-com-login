// tela_lista_contatos.dart
import 'package:flutter/material.dart';
import 'contato.dart';
import 'tela_formulario_contato.dart';

class TelaListaContatos extends StatefulWidget {
  const TelaListaContatos({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _TelaListaContatosState createState() => _TelaListaContatosState();
}

class _TelaListaContatosState extends State<TelaListaContatos> {
  List<Contato> contatos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos'),
      ),
      body: contatos.isEmpty
          ? const Center(child: Text('Nenhum contato cadastrado.'))
          : ListView.builder(
              itemCount: contatos.length,
              itemBuilder: (context, indice) {
                final contato = contatos[indice];
                return ListTile(
                  title: Text(contato.nome),
                  subtitle: Text('${contato.telefone}\n${contato.email}'),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaFormularioContato(
                          contato: contato,
                          aoSalvar: (contatoAtualizado) {
                            setState(() {
                              contatos[indice] = contatoAtualizado;
                            });
                          },
                          aoDeletar: () {
                            setState(() {
                              contatos.removeAt(indice);
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaFormularioContato(
                aoSalvar: (novoContato) {
                  setState(() {
                    contatos.add(novoContato);
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
