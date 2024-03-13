import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(
      {required String email, required String password});
  Future<Either<Failure, Unit>> register({
    required String email,
    required String password,
    required String userName,
    String? prfileImagePath,
  });
}
