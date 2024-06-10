import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> updateProfile({required String userId,required UserInfoEntity model, required String oldImageUrl});
  Future<Either<Failure, UserInfoEntity>> getProfileInfo(
      {required String userId});
  Future<Either<Failure, Stream<UserInfoEntity>>> getProfileDetails(
      {required String userId});
Future<Either<Failure, Stream<List<PostEntity>>>>getPosts({required String userId});
  Future<Either<Failure, Unit>> deletePost({required String postId,required String userId});
}
