import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/errors/execptions.dart';
import 'package:social_app/src/core/models/user_info_model.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/profile/data/datasources/profile_reomte_datasource.dart';
import 'package:social_app/src/features/profile/domain/repositories/prfile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.profileRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> deletePost({required String postId}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts({required String userId}) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserInfoModel>> getProfileInfo(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        UserInfoModel userInfo =
            await profileRemoteDatasource.getProfileInfo(userId: userId);
        return Right(userInfo);
      } on ServerExecption {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(
      {required String userId, required UserInfoEntity model}) async {
    if (await networkInfo.isConnected) {
      try {
        UserInfoModel userInfo = UserInfoModel(
            userId: model.userId,
            userName: model.userName,
            email: model.email,
            profileImageURL: model.profileImageURL,
            address: model.address,
            followers: model.followers,
            following: model.following,
            bio: model.bio);
        await profileRemoteDatasource.updateProfile(
            userId: userId, model: userInfo);
        return const Right(unit);
      } on ServerExecption {
        return Left(ServerFailure());
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
