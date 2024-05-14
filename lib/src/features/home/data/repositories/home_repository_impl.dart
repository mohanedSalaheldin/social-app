import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/home/data/datasoures/home_remote_datasource.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class HomeRpositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final NetworkInfo networkInfo;

  HomeRpositoryImpl(
      {required this.homeRemoteDataSource, required this.networkInfo});

  @override
  void comment(String postId, String comment) {
    // TODO: implement comment
  }

  @override
  Stream<List<PostModel>> getPosts() {
    return homeRemoteDataSource.getPosts();
  }

  @override
  void likePost(String postId) {
    // TODO: implement likePost
  }
}
