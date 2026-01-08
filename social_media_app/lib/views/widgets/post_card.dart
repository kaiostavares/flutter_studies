import 'package:flutter/material.dart';
import '../../models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;

  const PostCard({super.key, required this.post, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header (Avatar + Username)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(post.userAvatar),
                radius: 16,
              ),
              const SizedBox(width: 10),
              Text(
                post.username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),
        ),

        // Post Image
        Image.network(
          post.imageUrl,
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 400,
              color: Colors.grey[200],
              child: const Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            height: 400,
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
          ),
        ),

        // Action Buttons
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
              ), // Could change to favorite if liked
              onPressed: onLike,
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: () {},
            ),
            IconButton(icon: const Icon(Icons.send), onPressed: () {}),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {},
            ),
          ],
        ),

        // Likes Count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '${post.likes} curtidas',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: '${post.username} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${post.title} - ${post.body}'),
              ],
            ),
          ),
        ),

        // Comments Link
        if (post.comments.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              'Ver todos os ${post.comments.length} comentários',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),

        const SizedBox(height: 10),
      ],
    );
  }
}
