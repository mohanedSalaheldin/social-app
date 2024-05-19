import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/auth/data/datasources/auth_remote_datasource.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.authRemoteDataSource, required this.networkInfo});

  var state = AuthRemoteDataSourceImpl();

  @override
  Future<Either<Failure, Unit>> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.emailLogin(email: email, password: password);
        return const Right(unit);
      } catch (e) {
        print(e.toString());
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> register({
    required String email,
    required String password,
    required String userName,
    required String prfileImagePath,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.emailRegister(
            email: email,
            password: password,
            userName: userName,
            profileImagePath: prfileImagePath);
        return const Right(unit);
      } catch (e) {
        print(e.toString());
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  void logout() async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.logout();
      } on Exception {
        // return LeftServerFailure();
      }
    } else {
      // return Left(OfflineFailure());
    }
  }

  @override
  User? getUser() {
    return authRemoteDataSource.getUser();
  }
}
