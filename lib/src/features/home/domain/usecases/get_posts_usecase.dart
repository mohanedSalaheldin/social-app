import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class HomeGetPostsUseCase {
  HomeRepository repository;
  HomeGetPostsUseCase({required this.repository});
  Future<Either<Failure, Stream<List<PostEntity>>>> call(
      {required String userId}) {
    return repository.getPosts(userId: userId);
  }
}
