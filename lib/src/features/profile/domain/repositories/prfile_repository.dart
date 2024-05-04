import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/auth/presentation/pages/profile_screen.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> updateProfile({required String userId,required UserInfoEntity model});
  Future<Either<Failure, UserInfoEntity>> getProfileInfo(
      {required String userId});
  Future<Either<Failure, List<PostEntity>>> getPosts({required String userId});
  Future<Either<Failure, Unit>> deletePost({required String postId});
}
