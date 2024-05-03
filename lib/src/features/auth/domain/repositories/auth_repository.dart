import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/src/core/errors/error.dart';

abstract class AuthRepository {
  User? getUser();
  // void uploadProfileImage({});
  Future<Either<Failure, Unit>> login(
      {required String email, required String password});
  void logout();
  Future<Either<Failure, Unit>> register({
    required String email,
    required String password,
    required String userName,
    File? prfileImagePath,
  });
}
