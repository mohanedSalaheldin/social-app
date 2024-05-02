import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/domain/entities/profile_user_entity.dart';
import 'package:social_app/src/features/profile/domain/repositories/prfile_repository.dart';

class GetProfileInfoUseCase {

  final ProfileRepository repository;
  GetProfileInfoUseCase({required this.repository});
  Future<Either<Failure, ProfileUserEntity>> call({required String userId}) {
    return repository.getProfileInfo(userId: userId);
  }
}