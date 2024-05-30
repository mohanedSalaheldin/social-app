import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';
import 'package:social_app/src/features/posts/domain/repositories/posts_repository.dart';

class PostsAddCommentUseCase {
  PostsRepository repository;
  PostsAddCommentUseCase({required this.repository});
 Future<Either<Failure, Unit>> call({required CommentEntity comment}) {
    return repository.addComment(comment: comment);
  }
}
