import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/domain/repositories/prfile_repository.dart';

class GetPostsUseCase {

  final ProfileRepository repository;
  GetPostsUseCase({required this.repository});
  Future<Either<Failure, List<PostEntity>>> call({required String userId}) {
    return repository.getPosts(userId: userId);
  }
}