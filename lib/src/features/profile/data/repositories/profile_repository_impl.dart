import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/models/post_model.dart';
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
  Future<Either<Failure, Unit>> deletePost(
      {required String postId, required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        await profileRemoteDatasource.deletePost(
            postId: postId, userId: userId);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<List<PostModel>>>> getPosts(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        Stream<List<PostModel>> posts =
            profileRemoteDatasource.getPosts(userId: userId);
        return Right(posts);
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserInfoModel>> getProfileInfo(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        UserInfoModel userInfo =
            await profileRemoteDatasource.getProfileInfo(userId: userId);
        return Right(userInfo);
      } catch (e) {
        print(e.toString());
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(
      {required String userId,
      required UserInfoEntity model,
      required String oldImageUrl}) async {
    if (await networkInfo.isConnected) {
      try {
        UserInfoModel userInfo = UserInfoModel(
            userId: model.userId,
            fcmToken: model.fcmToken,
            userName: model.userName,
            email: model.email,
            profileImageURL: model.profileImageURL,
            address: model.address,
            followers: model.followers,
            following: model.following,
            bio: model.bio);
        await profileRemoteDatasource.updateProfile(
            userId: userId, model: userInfo, oldImageUrl: oldImageUrl);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<UserInfoEntity>>> getProfileDetails(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        Stream<UserInfoEntity> stream =
            await profileRemoteDatasource.getProfileDetails(userId: userId);
        return Right(stream);
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
