import 'package:flutter/material.dart';
import '../viewmodels/feed_viewmodel.dart';
import 'widgets/post_card.dart';

class FeedView extends StatelessWidget {
  // Instanciando o ViewModel. Em apps maiores, usaria dependency injection ou provider.
  final FeedViewModel viewModel = FeedViewModel();

  FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instagram Clone',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.message_outlined),
            onPressed: () {},
          ),
        ],
      ),
      // ListenableBuilder para ouvir mudanças no ViewModel
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: viewModel.posts.length,
            itemBuilder: (context, index) {
              final post = viewModel.posts[index];
              return PostCard(
                post: post,
                onLike: () => viewModel.likePost(post.id),
              );
            },
          );
        },
      ),
    );
  }
}
