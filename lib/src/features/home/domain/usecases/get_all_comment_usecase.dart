import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/home/domain/entities/comment_entity.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class HomeGetAllCommentUseCase {
  HomeRepository repository;
  HomeGetAllCommentUseCase({required this.repository});
 Future<Either<Failure, Stream<List<CommentEntity>>>> call({required String postId}) {
    return repository.getComments(postId: postId);
  }
  
}