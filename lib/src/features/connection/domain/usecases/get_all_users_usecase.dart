import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/connection/domain/repositories/search_repository.dart';

class GetAllUsersUsecase {
  final ConnectionRepository repository;

  GetAllUsersUsecase({required this.repository});

   Future<Either<Failure, Stream<List<UserInfoEntity>>>> call() async {
    return await repository.getAllUsers();
  }
}
