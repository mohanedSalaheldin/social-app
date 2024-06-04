import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';

abstract class ConnectionRepository {
  Future<Either<Failure, List<UserInfoEntity>>> searchForUser(
      {required String keyword});
   Future<Either<Failure, Stream<List<UserInfoEntity>>>> getAllUsers();
  Future<Either<Failure, Unit>> followUnfollowUser(
      {required String currentUserId, required String otherUserId});
}
