import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class HomeRemoveCommentUseCase {
  HomeRepository repository;
  HomeRemoveCommentUseCase({required this.repository});
 Future<Either<Failure, Unit>> call({required String postId, required String commentID}) {
    return repository.removeComment(postId: postId, commentID: commentID);
  }
  
}