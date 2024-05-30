import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/errors/execptions.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/posts/data/datasources/posts_remote_datasource.dart';
import 'package:social_app/src/features/posts/data/models/comment_model.dart';
import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';
import 'package:social_app/src/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDatasSource postsRemoteDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.postsRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> addPost(
      {required String userID, required PostEntity postEntity}) async {
    PostModel postModel = PostModel.forEntity(postEntity);
    if (await networkInfo.isConnected) {
      try {
        await postsRemoteDataSource.addPost(
            userID: userID, postModel: postModel);
        return const Right(unit);
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
        postsRemoteDataSource.likeOrDislikePost(postId: postId, userId: userId);
        return Future.value(const Right(unit));
      } catch (e) {
        return Future.value(Left(ServerFailure(error: e.toString())));
      }
    } else {
      return Future.value(Left(OfflineFailure()));
    }
  }

  
  @override
  Future<Either<Failure, Unit>> addComment(
      {required CommentEntity comment}) async {


    if (await networkInfo.isConnected) {
      try {
        postsRemoteDataSource.addComment(comment: CommentModel.forEntity(comment));
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
            postsRemoteDataSource.getComments(postId: postId);
        return Right(comments);
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }


  @override
  Future<Either<Failure, Unit>> removeComment(
      {required String postId, required String commentID}) async {
    if (await networkInfo.isConnected) {
      try {
        postsRemoteDataSource.removeComment(
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
