import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';

abstract class PostsRepository {
  Future<Either<Failure, Unit>> addPost(
      {required String userID, required PostEntity postEntity});
}
