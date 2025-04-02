//https://github.com/GabrielSantosSmylle

import 'package:flutter/material.dart';
import 'package:flutter_application_2/utils/dados_exemploini.dart';

// Essa tela serve pra adicionar um novo filme
// Recebe o ID do genero e uma funcao pra adicionar o filme na lista
// Essa tinha ido em parcial pois adicionava mas o metodo de atualizar quando já adc tava errado so atualizava quando voltava na homescreen

class NovoFilmeScreen extends StatefulWidget {
  final int idGenero;
  final Function(Filme) adicionarFilme;

  const NovoFilmeScreen({
    super.key,
    required this.idGenero,
    required this.adicionarFilme,
  });

  @override
  State<NovoFilmeScreen> createState() => _NovoFilmeScreenState();
}

class _NovoFilmeScreenState extends State<NovoFilmeScreen> {
  // Controladores dos campos de texto
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _diretorController = TextEditingController();

  // Funcao chamada quando clica em "Salvar"
  void _salvar() {
    final titulo = _tituloController.text.trim();
    final diretor = _diretorController.text.trim();

    // Valida se os campos estao preenchidos
    if (titulo.isEmpty || diretor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    // Cria um novo objeto Filme com ID automatico unico
    final novoFilme = Filme(
      id: DateTime.now().millisecondsSinceEpoch,
      titulo: titulo,
      diretor: diretor,
      idGenero: widget.idGenero,
    );

    // Adiciona o filme na lista e volta pra tela anterior
    widget.adicionarFilme(novoFilme);
    Navigator.pop(context, novoFilme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mostra o ID do genero so pra referencia
            Text('Genero ID: ${widget.idGenero}'),
            SizedBox(height: 10),
            // Campo de titulo do filme
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Titulo'),
            ),
            // Campo de diretor do filme
            TextField(
              controller: _diretorController,
              decoration: InputDecoration(labelText: 'Diretor'),
            ),
          ],
        ),
      ),
      // Botao salvar la embaixo
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
