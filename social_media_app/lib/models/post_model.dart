class Post {
  final String id;
  final String username;
  final String userAvatar;
  final String imageUrl;
  final String title;
  final String body;
  int likes;
  final List<String> comments;

  Post({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.imageUrl,
    required this.title,
    required this.body,
    this.likes = 0,
    this.comments = const [],
  });
}
