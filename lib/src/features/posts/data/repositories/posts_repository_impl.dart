import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/errors/execptions.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/posts/data/datasources/posts_remote_datasource.dart';
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
}
