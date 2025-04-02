//https://github.com/GabrielSantosSmylle

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/filmes_detail_screen.dart';
import 'package:flutter_application_2/screens/novo_filme_screen.dart';
import 'package:flutter_application_2/utils/dados_exemploini.dart';

// Essa tela mostra os filmes de um genero especifico
// Da pra editar, remover ou adicionar novos filmes esse ja tinha feito na v1 mas tava errado porque so salvava se saisse do app e voltasse da primeira tela

class FilmesListScreen extends StatefulWidget {
  final Genero genero;
  final List<Filme> filmes;
  final List<Genero> generos;
  final Function(Filme) atualizarFilme;

  const FilmesListScreen({
    super.key,
    required this.genero,
    required this.filmes,
    required this.generos,
    required this.atualizarFilme,
  });

  @override
  State<FilmesListScreen> createState() => _FilmesListScreenState();
}

class _FilmesListScreenState extends State<FilmesListScreen> {
  // Essa função filtra so os filmes que sao do genero atual
  List<Filme> getFilmesDoGenero() {
    return widget.filmes
        .where((filme) => filme.idGenero == widget.genero.id)
        .toList();
  }

  // Aqui é a função que abre um alerta pra confirmar se quer excluir o filme um validador
  void _removerFilme(Filme filme) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir Filme'),
        content: Text('Deseja excluir o filme "${filme.titulo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Remove o filme da lista
              setState(() {
                widget.filmes.removeWhere((f) => f.id == filme.id);
              });
              Navigator.pop(context);
              // Mostra um aviso que foi excluido com sucesso
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Filme "${filme.titulo}" excluído.')),
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
    final filmesFiltrados = getFilmesDoGenero();

    return Scaffold(
      appBar: AppBar(
        // Mostra o nome do genero no topo da interface
        title: Text('${widget.genero.nome} (ID: ${widget.genero.id})'),
      ),
      body: filmesFiltrados.isEmpty
          // Se não tem filme no genero, mostra mensagem pra termos um validador que a persistencia ta funcionando
          ? const Center(child: Text('Nenhum filme neste gênero.'))
          // Senão, lista os filmes do gênero
          : ListView.builder(
              itemCount: filmesFiltrados.length,
              itemBuilder: (context, index) {
                final filme = filmesFiltrados[index];
                return ListTile(
                  title: Text('${filme.titulo} (ID: ${filme.id})'),
                  subtitle: Text('Diretor: ${filme.diretor} | Gênero ID: ${filme.idGenero}'),
                  // Quando clica no filme, abre a tela de edição
                  onTap: () async {
                    final editado = await Navigator.push<Filme>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FilmeDetailScreen(
                          filme: filme,
                          generos: widget.generos,
                          generoAtual: widget.genero,
                        ),
                      ),
                    );

                    // Se voltou com edição feita, atualiza o filme
                    if (editado != null) {
                      setState(() {
                        widget.atualizarFilme(editado);
                      });
                    }
                  },
                  // Botão pra excluir o filme
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removerFilme(filme),
                  ),
                );
              },
            ),
      // Botão na parte de baixo pra adicionar novo filme
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            // Abre a tela de novo filme
            final novoFilme = await Navigator.push<Filme>(
              context,
              MaterialPageRoute(
                builder: (_) => NovoFilmeScreen(
                  idGenero: widget.genero.id,
                  adicionarFilme: (filme) {
                    setState(() {
                      widget.filmes.add(filme);
                    });
                  },
                ),
              ),
            );

            // Se o usuário criou um filme novo, atualiza a lista 
            if (novoFilme != null) {
              widget.atualizarFilme(novoFilme);
            }
          },
          child: Text('Novo Filme'),
        ),
      ),
    );
  }
}
