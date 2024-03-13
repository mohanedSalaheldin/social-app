import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});
  Future<Either<Failure, Unit>> call({
    required String email,
    required String password,
    required String userName,
    String? prfileImagePath,
  }) {
    return repository.register(
        email: email,
        password: password,
        userName: userName,
        prfileImagePath: prfileImagePath);
  }
}
