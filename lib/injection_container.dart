import 'package:get_it/get_it.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';

import 'package:social_app/src/features/home/data/datasoures/home_remote_datasource.dart';
import 'package:social_app/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:social_app/src/features/home/domain/usecasese/comment_post_usecase.dart';
import 'package:social_app/src/features/home/domain/usecasese/get_posts_usecase.dart';
import 'package:social_app/src/features/home/domain/usecasese/like_post_usecase.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/src/features/profile/data/datasources/profile_reomte_datasource.dart';
import 'package:social_app/src/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:social_app/src/features/profile/domain/repositories/prfile_repository.dart';
import 'package:social_app/src/features/profile/domain/usecases/delete_post_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_profile_info.dart';
import 'package:social_app/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_app/src/features/search/data/datasources/search_remote_datasource.dart';
import 'package:social_app/src/features/search/data/repositories/search_repository_impl.dart';
import 'package:social_app/src/features/search/domain/repositories/search_repository.dart';
import 'package:social_app/src/features/search/domain/usecases/search_for_user_usecase.dart';
import 'package:social_app/src/features/search/presentation/cubit/search_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
/* --------------------Features-------------------- */
// Quates
  // Bloc
  sl.registerFactory(
    () => ProfileCubit(
      deletePostUseCase: sl(),
      getPostsUseCase: sl(),
      getProfileInfoUseCase: sl(),
      updateProfileUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => SearchCubit(
      searchForUserUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => HomeCubit(
      commentPostsUseCase: sl(),
      getPostsUseCase: sl(),
      likePostsUseCase: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileRemoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      searchRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // -------------------------------(home)-----------------------------------
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRpositoryImpl(
      homeRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // UseCases
  // -------------------------------(Profile)--------------------------------
  sl.registerLazySingleton(() => UpdateProfileUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfileInfoUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteProfilePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfilePostsUseCase(repository: sl()));
  // -------------------------------(Search)--------------------------------
  sl.registerLazySingleton(() => SearchForUserUseCase(repository: sl()));
  // -------------------------------(home)----------------------------------
  sl.registerLazySingleton(() => GetPostsUseCase(repository: sl()));
  sl.registerLazySingleton(() => LikePostsUseCase(repository: sl()));
  sl.registerLazySingleton(() => CommentPostsUseCase(repository: sl()));

/* --------------------Core-------------------- */
  // -------------------------------(Profile)--------------------------------
  sl.registerLazySingleton<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasourceImpl());
  // -------------------------------(Search)--------------------------------
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl());
  // -------------------------------(home)-----------------------------------
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl());
/* --------------------External-------------------- */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
