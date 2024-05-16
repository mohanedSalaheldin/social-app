import 'package:get_it/get_it.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:social_app/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:social_app/src/features/home/domain/usecases/comment_post_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/get_all_comment_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/like_unlike_post_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/remove_comment_usecase.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/src/features/posts/data/datasources/posts_remote_datasource.dart';
import 'package:social_app/src/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:social_app/src/features/posts/domain/repositories/posts_repository.dart';
import 'package:social_app/src/features/posts/domain/usecases/posts_add_usecase.dart';
import 'package:social_app/src/features/posts/presentation/cubit/posts_cubit.dart';
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
    () => PostsCubit(
      postsAddPostUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => HomeCubit(
      removeCommentUseCase: sl(),
      addCommentUseCase: sl(),
      getPostsUseCase: sl(),
      likePostsUseCase: sl(),
      getAllCommentUseCase: sl(),
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
  // -------------------------------(Posts)-----------------------------------

  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      postsRemoteDataSource: sl(),
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
  sl.registerLazySingleton(() => HomeAddCommentUseCase(repository: sl()));
  sl.registerLazySingleton(() => HomeGetAllCommentUseCase(repository: sl()));
  sl.registerLazySingleton(() => HomeRemoveCommentUseCase(repository: sl()));

  // -------------------------------(Posts)--------------------------------
  sl.registerLazySingleton(() => PostsAddPostUsecase(repository: sl()));

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

  // -------------------------------(Posts)--------------------------------
  sl.registerLazySingleton<PostsRemoteDatasSource>(
      () => PostsRemoteDatasSourceImpl());
/* --------------------External-------------------- */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
