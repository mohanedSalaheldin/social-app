import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/domain/repositories/prfile_repository.dart';

class DeleteProfilePostUseCase {
  final ProfileRepository repository;
  DeleteProfilePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(
      {required String postId, required String userId}) {
    return repository.deletePost(postId: postId, userId: userId);
  }
}
