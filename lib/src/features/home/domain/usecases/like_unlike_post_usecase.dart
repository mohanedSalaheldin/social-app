import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class LikePostsUseCase {
  HomeRepository repository;
  LikePostsUseCase({required this.repository});
 Future<Either<Failure, Unit>> call({required String postId}) {
    return repository.likeUnlikePost(postId: postId);
  }
}
