import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:social_app/src/features/posts/domain/repositories/posts_repository.dart';

class PostsLikeOrDisLikePostUseCase {
  PostsRepository repository;
  PostsLikeOrDisLikePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(
      {required String postId, required String userId}) {
    print("postId on usease: $postId");
    print("userId on usease: $userId");
    return repository.likeOrDisLikePost(postId: postId, userId: userId);
  }
}
