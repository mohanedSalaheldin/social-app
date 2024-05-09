import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/posts/domain/repositories/posts_repository.dart';

class PostsAddPostUsecase {
  final PostsRepository repository;

  PostsAddPostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(
      {required String userID, required PostEntity postEntity}) {
    return repository.addPost(userID: userID, postEntity: postEntity);
  }
}
