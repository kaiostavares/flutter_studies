import 'package:flutter/material.dart';
import '../models/atracao.dart';
import '../view_models/favorites_view_model.dart';
import 'atracao_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FavoritesViewModel _viewModel = FavoritesViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atrações')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          return ListView.builder(
            itemCount: listaAtracoes.length,
            itemBuilder: (context, index) {
              final atracao = listaAtracoes[index];
              final isFavorito = _viewModel.isFavorite(atracao);

              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AtracaoPage(atracao: atracao),
                    ),
                  );
                },
                title: Text(atracao.nome),
                subtitle: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: atracao.tags
                      .map((tag) => Chip(label: Text('#$tag')))
                      .toList(),
                ),
                leading: CircleAvatar(child: Text('${atracao.dia}')),
                trailing: IconButton(
                  onPressed: () {
                    _viewModel.toggleFavorite(atracao);
                  },
                  icon: isFavorito
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
