// dados_exemplo.dart
// Aqui eu preferi fazer uma utils pra fazer os models de filme e genero, e já fazer um pré load dos exemplos já cadastrados

class Filme {
  int id;
  String titulo;
  String diretor;
  int idGenero;

  Filme({
    required this.id,
    required this.titulo,
    required this.diretor,
    required this.idGenero,
  });
}

class Genero {
  int id;
  String nome;

  Genero({
    required this.id,
    required this.nome,
  });
}

// Lista de generos (categorias) pre carregados
List<Genero> generos = [
  Genero(id: 1, nome: 'Ação'),
  Genero(id: 2, nome: 'Comédia'),
  Genero(id: 3, nome: 'Drama'),
];

// Lista de filmes pre carregados
List<Filme> filmes = [
  Filme(id: 1, titulo: 'Duro de Matar', diretor: 'John McTiernan', idGenero: 1),
  Filme(id: 2, titulo: 'Todo Mundo em Pânico', diretor: 'Keenen Ivory Wayans', idGenero: 2),
  Filme(id: 3, titulo: 'Forrest Gump', diretor: 'Robert Zemeckis', idGenero: 3),
];
