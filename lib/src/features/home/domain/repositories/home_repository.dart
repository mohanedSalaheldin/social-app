import 'package:social_app/src/core/models/post_model.dart';

abstract class HomeRepository {
  Stream<List<PostModel>> getPosts();
  void likePost(String postId);
  void comment(String postId, String comment);
}
