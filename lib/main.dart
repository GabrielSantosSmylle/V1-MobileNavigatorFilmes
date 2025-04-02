//https://github.com/GabrielSantosSmylle

import 'package:flutter/material.dart';
import 'package:flutter_application_2/utils/dados_exemploini.dart';
import 'screens/genero_list_screen.dart';

// Ponto de entrada do app
void main() {
  runApp(MyApp());
}

// Esse widget representa o app inteiro
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Aqui eu uso as listas de dados que fiz na utils pra fazer um pre load na home
  List<Genero> listaGeneros = generos;
  List<Filme> listaFilmes = filmes;

  // Essa funcao atualiza um filme que foi editado 
  void atualizarFilme(Filme filmeEditado) {
    setState(() {
      int index = listaFilmes.indexWhere((f) => f.id == filmeEditado.id);
      if (index != -1) {
        listaFilmes[index] = filmeEditado;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalogo de Filmes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryColor: Color(0xFF8A05BE), 
    ),
      // Tela inicial do app
      home: GenerosListScreen(
        generos: listaGeneros,
        filmes: listaFilmes,
        atualizarFilme: atualizarFilme,
      ),
    );
  }
}
