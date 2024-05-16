import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/home/domain/entities/comment_entity.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class HomeAddCommentUseCase {
  HomeRepository repository;
  HomeAddCommentUseCase({required this.repository});
 Future<Either<Failure, Unit>> call({required CommentEntity comment}) {
    return repository.addComment(comment: comment);
  }
}
