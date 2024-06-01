import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';

abstract class PostsRepository {
  Future<Either<Failure, Unit>> addPost(
      {required String userID, required PostEntity postEntity});
  Future<Either<Failure, Unit>> likeOrDisLikePost(
      {required String postId, required String userId});

 Future<Either<Failure, Unit>> addComment({required CommentEntity comment});
  Future<Either<Failure, Unit>> removeComment(
      {required String postId, required String commentID});
  Future<Either<Failure, Stream<List<CommentEntity>>>> getComments(
      {required String postId});

}
