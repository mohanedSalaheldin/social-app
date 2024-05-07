import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<UserInfoEntity>>> searchForUser(
      {required String keyword});
}
