import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/data/datasources/profile_reomte_datasource.dart';
import 'package:social_app/src/features/profile/domain/repositories/prfile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;

  ProfileRepositoryImpl({required this.profileRemoteDatasource});

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
  Future<Either<Failure, UserInfoEntity>> getProfileInfo(
      {required String userId}) {
    // TODO: implement getProfileInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateProfile({required String userId}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
