//https://github.com/GabrielSantosSmylle

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/filmes_list_screen.dart';
import 'package:flutter_application_2/screens/novo_genero_screen.dart';
import 'package:flutter_application_2/utils/dados_exemploini.dart';

// Essa tela mostra a lista de categorias (generos)
// Da pra ver os filmes de cada genero, excluir ou adicionar novo que foi a coisa que mais faltou acho no meu app v1 
//eu tentei implementar mas nao adicionava o novo genero nas categorias listadas

class GenerosListScreen extends StatefulWidget {
  final List<Genero> generos;
  final List<Filme> filmes;
  final Function(Filme) atualizarFilme;

  const GenerosListScreen({
    super.key,
    required this.generos,
    required this.filmes,
    required this.atualizarFilme,
  });

  @override
  State<GenerosListScreen> createState() => _GenerosListScreenState();
}

class _GenerosListScreenState extends State<GenerosListScreen> {
  // Quando clica pra excluir um genero, mostra alerta pra confirmar validador simples
  void _removerGenero(Genero genero) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir Categoria'),
        content: Text('Deseja excluir "${genero.nome}" e seus filmes vinculados?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Remove o genero e todos os filmes ligados a ele
              setState(() {
                widget.generos.removeWhere((g) => g.id == genero.id);
                widget.filmes.removeWhere((f) => f.idGenero == genero.id);
              });
              Navigator.pop(context);
              // Mostra mensagem confirmando
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Categoria excluida')),
              );
            },
            child: Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categorias')),
      body: ListView.builder(
        itemCount: widget.generos.length,
        itemBuilder: (context, index) {
          final genero = widget.generos[index];
          return ListTile(
            title: Text('${genero.nome} (ID: ${genero.id})'),
            // Quando clica na categoria, vai pra tela dos filmes daquele genero
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FilmesListScreen(
                    genero: genero,
                    filmes: widget.filmes,
                    generos: widget.generos,
                    atualizarFilme: widget.atualizarFilme,
                  ),
                ),
              );
            },
            // Botao de excluir genero
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removerGenero(genero),
            ),
          );
        },
      ),
      // Botao pra adicionar nova categoria
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NovoGeneroScreen()),
            ).then((value) {
              // Se voltou da tela e deu true, atualiza a tela
              if (value == true) setState(() {});
            });
          },
          child: Text('Nova Categoria'),
        ),
      ),
    );
  }
}
