import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'contato.dart';

class TelaFormularioContato extends StatefulWidget {
  final Contato? contato; // Contato opcional para edição
  final Function(Contato)
      aoSalvar; // Função a ser chamada ao salvar um contato.
  final Function()?
      aoDeletar; // Função opcional a ser chamada ao deletar um contato.

  const TelaFormularioContato({
    super.key,
    this.contato,
    required this.aoSalvar,
    this.aoDeletar,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TelaFormularioContatoState createState() => _TelaFormularioContatoState();
}

class _TelaFormularioContatoState extends State<TelaFormularioContato> {
  final _formKey = GlobalKey<FormState>(); // Chave usada para validação.
  late TextEditingController _nomeController;
  late TextEditingController _telefoneController;
  late TextEditingController _emailController;

  // Criação da máscara para telefone
  final mascaraTelefone = MaskTextInputFormatter(
    mask: '(##) #####-####', // Define o formato da máscara de telefone.
    filter: {"#": RegExp(r'[0-9]')}, // Permite apenas dígitos.
  );

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.contato?.nome ?? '');
    _telefoneController =
        TextEditingController(text: widget.contato?.telefone ?? '');
    _emailController = TextEditingController(text: widget.contato?.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contato == null ? 'Novo Contato' : 'Editar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Nome é obrigatório'; // Validação para campo vazio
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                inputFormatters: [mascaraTelefone],
                keyboardType: TextInputType.phone,
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Telefone é obrigatório'; // Validação para campo vazio
                  }
                  if (!RegExp(r'^\(\d{2}\) \d{5}-\d{4}$').hasMatch(valor)) {
                    return 'Formato de telefone inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'E-mail é obrigatório'; // Validação para campo vazio
                  }
                  if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                      .hasMatch(valor)) {
                    return 'Formato de e-mail inválido'; // Validação para formato correto
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final contato = Contato(
                      // Se o formulário for válido, cria um novo contato.
                      nome: _nomeController.text,
                      telefone: _telefoneController.text,
                      email: _emailController.text,
                    );
                    widget.aoSalvar(contato);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar'),
              ),
              if (widget.contato != null)
                ElevatedButton(
                  onPressed: () {
                    if (widget.aoDeletar != null) {
                      // Botão para deletar o contato, se existir
                      widget.aoDeletar!();
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Deletar'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
