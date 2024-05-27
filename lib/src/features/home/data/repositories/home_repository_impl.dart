import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:social_app/src/features/home/domain/entities/comment_entity.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class HomeRpositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final NetworkInfo networkInfo;

  HomeRpositoryImpl(
      {required this.homeRemoteDataSource, required this.networkInfo});

  @override
  Stream<List<PostModel>> getPosts() {
    return homeRemoteDataSource.getPosts();
  }

  @override
  Future<Either<Failure, Unit>> addComment(
      {required CommentEntity comment}) async {
    if (await networkInfo.isConnected) {
      try {
        homeRemoteDataSource.addComment(comment: comment);
        return Future.value(const Right(unit));
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Future.value(Left(OfflineFailure()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<CommentEntity>>>> getComments(
      {required String postId}) async {
    if (await networkInfo.isConnected) {
      try {
        Stream<List<CommentEntity>> comments =
            homeRemoteDataSource.getComments(postId: postId);
        return Right(comments);
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> likeOrDisLikePost(
      {required String postId, required String userId}) async {
    print("postId in repo: $postId");
    print("userId in repo: $userId");
    if (await networkInfo.isConnected) {
      try {
        homeRemoteDataSource.likeOrDislikePost(postId: postId, userId: userId);
        return Future.value(const Right(unit));
      } catch (e) {
        return Future.value(Left(ServerFailure(error: e.toString())));
      }
    } else {
      return Future.value(Left(OfflineFailure()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeComment(
      {required String postId, required String commentID}) async {
    if (await networkInfo.isConnected) {
      try {
        homeRemoteDataSource.removeComment(
            commentID: commentID, postId: postId);
        return Future.value(const Right(unit));
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Future.value(Left(OfflineFailure()));
    }
  }
}
