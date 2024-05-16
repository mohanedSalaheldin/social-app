import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/features/home/data/models/comment_model.dart';
import 'package:social_app/src/features/home/domain/entities/comment_entity.dart';

abstract class HomeRepository {
  Stream<List<PostModel>> getPosts();
  Future<Either<Failure, Unit>> likeUnlikePost({required String postId});
  Future<Either<Failure, Unit>> addComment({required CommentEntity comment});
  Future<Either<Failure, Unit>> removeComment(
      {required String postId, required String commentID});
   Future<Either<Failure, Stream<List<CommentEntity>>>>  getComments({required String postId});
}
