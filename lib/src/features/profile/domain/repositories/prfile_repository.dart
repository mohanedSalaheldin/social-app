import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/auth/presentation/pages/profile_screen.dart';
import 'package:social_app/src/features/profile/domain/entities/profile_user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> updateProfile({required String userId});
  Future<Either<Failure, ProfileUserEntity>> getProfileInfo(
      {required String userId});
  Future<Either<Failure, List<PostEntity>>> getPosts({required String userId});
  Future<Either<Failure, Unit>> deletePost({required String postId});
}
