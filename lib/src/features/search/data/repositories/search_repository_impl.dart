import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/errors/execptions.dart';
import 'package:social_app/src/core/models/user_info_model.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/search/data/datasources/search_remote_datasource.dart';
import 'package:social_app/src/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final NetworkInfo networkInfo;
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepositoryImpl(
      {required this.networkInfo, required this.searchRemoteDataSource});
  @override
  Future<Either<Failure, List<UserInfoEntity>>> searchForUser(
      {required String keyword}) async {
    if (await networkInfo.isConnected) {
      try {
        List<UserInfoModel> users =
            await searchRemoteDataSource.searchForUser(keyword: keyword);
        return Right(users);
      } on ServerExecption {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
