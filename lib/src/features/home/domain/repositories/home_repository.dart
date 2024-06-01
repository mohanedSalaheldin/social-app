import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/features/home/domain/entities/comment_entity.dart';

import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';


abstract class HomeRepository {
  Future<Either<Failure, Stream<List<PostEntity>>>> getPosts({required String userId});

  // Future<Either<Failure, Unit>> addComment({required comment});

 
}
