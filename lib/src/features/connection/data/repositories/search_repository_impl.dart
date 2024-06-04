import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/models/user_info_model.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/connection/data/datasources/search_remote_datasource.dart';
import 'package:social_app/src/features/connection/domain/repositories/search_repository.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  final NetworkInfo networkInfo;
  final ConnectionRemoteDataSource connectionRemoteDataSource;

  ConnectionRepositoryImpl(
      {required this.networkInfo, required this.connectionRemoteDataSource});
  @override
  Future<Either<Failure, List<UserInfoEntity>>> searchForUser(
      {required String keyword}) async {
    if (await networkInfo.isConnected) {
      try {
        List<UserInfoModel> users =
            await connectionRemoteDataSource.searchForUser(keyword: keyword);
        // print(users.length);
        return Right(users);
      } catch (e) {
        print(e.toString());
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> followUnfollowUser(
      {required String currentUserId, required String otherUserId}) async {
    if (await networkInfo.isConnected) {
      try {
        await connectionRemoteDataSource.followUnfollowUser(
            currentUserId: currentUserId, otherUserId: otherUserId);
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
  Future<Either<Failure, Stream<List<UserInfoEntity>>>> getAllUsers() async {
    if (await networkInfo.isConnected) {
      try {
        Stream<List<UserInfoEntity>> users =
            connectionRemoteDataSource.getAllUsers();
        return Right(users);
      } catch (e) {
        print(e.toString());
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
