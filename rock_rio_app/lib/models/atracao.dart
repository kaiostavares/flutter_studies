class Atracao {
  final String nome;
  final int dia;
  final List<String> tags;

  const Atracao({required this.nome, required this.dia, required this.tags});
}

const listaAtracoes = [
  Atracao(
    nome: "Iron Maiden",
    dia: 2,
    tags: ["Espetaculo", "Fas", "NovoAlbum", "2026", "Rock"],
  ),
  Atracao(nome: "Alok", dia: 3, tags: ["Influente", "Top", "Show"]),
  Atracao(
    nome: "Justin Bieber",
    dia: 4,
    tags: ["TopCharts", "Hits", "PríncipeDoPOP"],
  ),
  Atracao(
    nome: "Guns N’ Roses",
    dia: 8,
    tags: ["Sucesso", "Espetáculo", "Fas"],
  ),
  Atracao(nome: "Capital Inicial", dia: 9, tags: ["2019", "Novo Álbum", "Fas"]),
  Atracao(
    nome: "Green Day",
    dia: 9,
    tags: ["Sucesso", "Reconhecimento", "Show"],
  ),
  Atracao(nome: "Cold Play", dia: 10, tags: ["NovoAlbum", "Sucesso", "2011"]),
  Atracao(nome: "Ivete Sangalo", dia: 10, tags: ["Unica", "Carreiras", "Fas"]),
  Atracao(nome: "Racionais", dia: 3, tags: ["Hits", "Prêmios", "Respeito"]),
  Atracao(
    nome: "Gloria Groove",
    dia: 8,
    tags: ["Streams", "Representatividade", "Sucesso"],
  ),
  Atracao(
    nome: "Avril Lavigne",
    dia: 9,
    tags: ["Estreia", "Sucesso", "Lançamento"],
  ),
  Atracao(
    nome: "Ludmilla",
    dia: 10,
    tags: ["Representativade", "Sucesso", "Parcerias"],
  ),
];
