import 'package:flutter/material.dart';
import 'package:social_app/src/core/entites/post_entity.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key, required this.postEntity});
  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Center(
        child: Text('${postEntity.text} '),
      ),
    );
  }
}
