import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';

class HomeRpositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final NetworkInfo networkInfo;

  HomeRpositoryImpl(
      {required this.homeRemoteDataSource, required this.networkInfo});

  @override
  Stream<List<PostModel>> getPosts() {
    return homeRemoteDataSource.getPosts();
  }

}
