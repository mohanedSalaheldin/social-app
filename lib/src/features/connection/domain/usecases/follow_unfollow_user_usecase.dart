import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/connection/domain/repositories/search_repository.dart';

class FollowUnfollowUserUseCase {
  final ConnectionRepository repository;

  FollowUnfollowUserUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(
      {required String currentUserId,required String otherUserId}) async {
    return await repository.followUnfollowUser(currentUserId: currentUserId, otherUserId: otherUserId);
  }
}
