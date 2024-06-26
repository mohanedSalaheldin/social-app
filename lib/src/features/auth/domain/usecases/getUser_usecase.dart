import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/auth/domain/repositories/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository repository;

  GetUserUseCase({required this.repository});
  User? call() {
    return repository.getUser();
  }
}
