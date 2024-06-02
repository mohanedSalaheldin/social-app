import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';


abstract class HomeRepository {
  Future<Either<Failure, Stream<List<PostEntity>>>> getPosts({required String userId});
}
