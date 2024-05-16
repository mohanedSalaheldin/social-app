import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class HomeLikeOrDisLikePostUseCase {
  HomeRepository repository;
  HomeLikeOrDisLikePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(
      {required String postId, required String userId}) {
    return repository.likeOrDisLikePost(postId: postId, userId: postId);
  }
}
