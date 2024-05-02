import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/domain/repositories/prfile_repository.dart';

class DeletePostUseCase {
  final ProfileRepository repository;
  DeletePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call({required String postId}) {
    return repository.deletePost(postId: postId);
  }
}
