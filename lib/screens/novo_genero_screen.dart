//https://github.com/GabrielSantosSmylle

import 'package:flutter/material.dart';
import 'package:flutter_application_2/utils/dados_exemploini.dart';

// Essa tela serve pra criar uma nova categoria (genero) de filmes
// So precisa digitar o nome e salvar para fazer demanda

class NovoGeneroScreen extends StatefulWidget {
  const NovoGeneroScreen({super.key});

  @override
  State<NovoGeneroScreen> createState() => _NovoGeneroScreenState();
}

class _NovoGeneroScreenState extends State<NovoGeneroScreen> {
  // Controlador do campo de texto
  final TextEditingController _nomeController = TextEditingController();

  // Funcao chamada ao clicar em "Salvar"
  void _salvar() {
    final nome = _nomeController.text.trim();

    // Se nao digitou nada, mostra aviso pedindo pra digitar a categ
    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Digite o nome da categoria.')),
      );
      return;
    }

    // Cria novo objeto Genero com ID automatico unico
    final novoGenero = Genero(
      id: DateTime.now().millisecondsSinceEpoch,
      nome: nome,
    );

    // Adiciona na lista global e volta pra tela anterior
    generos.add(novoGenero);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Categoria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _nomeController,
          decoration: InputDecoration(labelText: 'Nome da Categoria'),
        ),
      ),
      // Botao salvar na parte de baixo
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _salvar,
          child: Text('Salvar'),
        ),
      ),
    );
  }
}
