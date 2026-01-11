import 'package:flutter/material.dart';
import '../models/post_model.dart';

class FeedViewModel extends ChangeNotifier {
  List<Post> posts = [];
  bool isLoading = false;

  FeedViewModel() {
    loadPosts();
  }

  Future<void> loadPosts() async {
    isLoading = true;
    notifyListeners();

    // Simula delay de API
    await Future.delayed(const Duration(seconds: 1));

    // Mock Data
    posts = [
      Post(
        id: '1',
        username: 'kaio.tavares',
        userAvatar: 'https://i.pravatar.cc/150?u=kaio',
        imageUrl: 'https://picsum.photos/seed/1/600/600',
        title: 'Estudando Flutter',
        body:
            'A arquitetura MVVM ajuda muito na organização do código! #flutter #dev',
        likes: 120,
        comments: ['Muito bom!', 'Continua assim!', 'Top!'],
      ),
      Post(
        id: '2',
        username: 'flutter.dev',
        userAvatar: 'https://i.pravatar.cc/150?u=flutter',
        imageUrl: 'https://picsum.photos/seed/2/600/600',
        title: 'Widgets everywhere',
        body: 'Construindo interfaces bonitas com composição. #widgets #ui',
        likes: 342,
        comments: ['Awesome'],
      ),
      Post(
        id: '3',
        username: 'dart.lang',
        userAvatar: 'https://i.pravatar.cc/150?u=dart',
        imageUrl: 'https://picsum.photos/seed/3/600/600',
        title: 'Dart 3 Power',
        body: 'Records e Pattern Matching são incríveis.',
        likes: 89,
        comments: [],
      ),
    ];

    isLoading = false;
    notifyListeners();
  }

  void likePost(String postId) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      posts[index].likes++;
      notifyListeners();
    }
  }
}
