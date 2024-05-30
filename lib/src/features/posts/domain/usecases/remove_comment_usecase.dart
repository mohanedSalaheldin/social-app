import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/posts/domain/repositories/posts_repository.dart';

class PostsRemoveCommentUseCase {
  PostsRepository repository;
  PostsRemoveCommentUseCase({required this.repository});
 Future<Either<Failure, Unit>> call({required String postId, required String commentID}) {
    return repository.removeComment(postId: postId, commentID: commentID);
  }
  
}