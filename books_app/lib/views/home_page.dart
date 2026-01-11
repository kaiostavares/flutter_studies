import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  var titulo = '';
  var itemCount = 0;

  void _buscarLivros() async {
    titulo = _controller.text;
    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': '{$titulo}',
    });
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      itemCount = jsonResponse['totalItems'];
      setState(() {});
      print('Number of books about $titulo: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(controller: _controller),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                _buscarLivros();
              },
              icon: const Icon(Icons.search),
              label: const Text('Pesquisar'),
            ),
            const SizedBox(height: 16),
            Text(
              'Foram encontrados $itemCount livros sobre $titulo: ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
