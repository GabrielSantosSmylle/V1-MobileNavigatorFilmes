//https://github.com/GabrielSantosSmylle
import 'package:flutter/material.dart';
import 'package:flutter_application_2/utils/dados_exemploini.dart';

// Essa tela serve pra editar um filme j existente.
// Recebe o filme atual, o gênero atual e a lista de gêneros.

class FilmeDetailScreen extends StatefulWidget {
  final Filme filme;
  final Genero generoAtual;
  final List<Genero> generos;

  const FilmeDetailScreen({
    super.key,
    required this.filme,
    required this.generos,
    required this.generoAtual,
  });

  @override
  State<FilmeDetailScreen> createState() => _FilmeDetailScreenState();
}

class _FilmeDetailScreenState extends State<FilmeDetailScreen> {
  // Controladores para pegar o texto que o usuário digita
  late TextEditingController _tituloController;
  late TextEditingController _diretorController;
  // Aqui eu salvo o ID do gênero que foi selecionado
  late int _generoSelecionado;

  @override
  void initState() {
    super.initState();
    // Pego os dados do filme original e coloco nos campos
    _tituloController = TextEditingController(text: widget.filme.titulo);
    _diretorController = TextEditingController(text: widget.filme.diretor);
    _generoSelecionado = widget.filme.idGenero;
  }

  @override
  void dispose() {
    // Libera memória quando a tela fecha pra manter melhor funcionamento do app
    _tituloController.dispose();
    _diretorController.dispose();
    super.dispose();
  }

  void _salvar() {
    // Validação: se algum campo estiver vazio, mostra aviso pra fazer uma validacao basica
    if (_tituloController.text.trim().isEmpty ||
        _diretorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos!')),
      );
      return;
    }

    // Cria um novo objeto Filme com os dados atualizados
    final atualizado = Filme(
      id: widget.filme.id,
      titulo: _tituloController.text.trim(),
      diretor: _diretorController.text.trim(),
      idGenero: _generoSelecionado,
    );

    // Volta pra tela anterior e envia o filme editado
    Navigator.pop(context, atualizado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título dinâmico com o ID do filme
        title: Text('Editar Filme (ID: ${widget.filme.id})'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo para editar o título
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            // Campo para editar o diretor
            TextField(
              controller: _diretorController,
              decoration: InputDecoration(labelText: 'Diretor'),
            ),
            const SizedBox(height: 20),
            // Dropdown para escolher o gênero
            DropdownButtonFormField<int>(
              value: _generoSelecionado,
              decoration: InputDecoration(labelText: 'Categoria'),
              items: widget.generos.map((g) {
                return DropdownMenuItem<int>(
                  value: g.id,
                  child: Text('${g.nome} (ID: ${g.id})'),
                );
              }).toList(),
              onChanged: (valor) {
                setState(() {
                  _generoSelecionado = valor!;
                });
              },
            ),
            const SizedBox(height: 40),
            // Botão salvar com tamanho cheio na tela
            ElevatedButton(
              onPressed: _salvar,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
