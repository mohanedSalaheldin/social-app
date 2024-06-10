import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/domain/repositories/prfile_repository.dart';

class GetProfileDetailsUseCase {
  final ProfileRepository repository;
  GetProfileDetailsUseCase({required this.repository});
  Future<Either<Failure, Stream<UserInfoEntity>>> call({required String userId}) {
    return repository.getProfileDetails(userId: userId);
  }
}
