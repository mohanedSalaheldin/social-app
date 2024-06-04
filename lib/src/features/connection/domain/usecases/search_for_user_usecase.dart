import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/connection/domain/repositories/search_repository.dart';

class SearchForUserUseCase {
  final ConnectionRepository repository;

  SearchForUserUseCase({required this.repository});

  Future<Either<Failure, List<UserInfoEntity>>> call(
      {required String keyword}) async {
    return await repository.searchForUser(keyword: keyword);
  }
}


