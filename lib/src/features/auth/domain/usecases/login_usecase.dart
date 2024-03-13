import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(
      {required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
