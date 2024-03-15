import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/auth/data/datasources/auth_remote_datasource.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.authRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.emailLogin(email: email, password: password);
        return const Right(unit);
      } on Exception {
        return Left(ServerFailure());
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
    String? prfileImagePath,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.emailRegister(
            email: email,
            password: password,
            userName: userName,
            prfileImagePath: prfileImagePath);
        return const Right(unit);
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
