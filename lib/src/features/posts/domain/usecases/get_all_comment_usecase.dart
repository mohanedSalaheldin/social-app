import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';
import 'package:social_app/src/features/posts/domain/repositories/posts_repository.dart';

class PostsGetAllCommentUseCase {
  PostsRepository repository;
  PostsGetAllCommentUseCase({required this.repository});
 Future<Either<Failure, Stream<List<CommentEntity>>>> call({required String postId}) {
    return repository.getComments(postId: postId);
  }
  
}