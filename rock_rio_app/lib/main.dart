import 'package:flutter/material.dart';

void main() {
  runApp(const RockInRio());
}

class RockInRio extends StatelessWidget {
  const RockInRio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock in Rio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Atracao> _listaFavoritos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atrações')),
      body: ListView.builder(
        itemCount: listaAtracoes.length,
        itemBuilder: (context, index) {
          final isFavorito = _listaFavoritos.contains(listaAtracoes[index]);
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AtracaoPage(atracao: listaAtracoes[index]),
                ),
              );
            },
            title: Text(listaAtracoes[index].nome),
            subtitle: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: listaAtracoes[index].tags
                  .map((tag) => Chip(label: Text('#$tag')))
                  .toList(),
            ),
            leading: CircleAvatar(child: Text('${listaAtracoes[index].dia}')),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  if (isFavorito) {
                    _listaFavoritos.remove(listaAtracoes[index]);
                  } else {
                    _listaFavoritos.add(listaAtracoes[index]);
                  }
                });
              },
              icon: isFavorito
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border),
            ),
          );
        },
      ),
    );
  }
}

class AtracaoPage extends StatelessWidget {
  const AtracaoPage({super.key, required this.atracao});

  final Atracao atracao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(atracao.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final tag in atracao.tags) Chip(label: Text('#$tag')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}

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
