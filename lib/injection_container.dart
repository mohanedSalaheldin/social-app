import 'package:get_it/get_it.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/profile/data/datasources/profile_reomte_datasource.dart';
import 'package:social_app/src/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:social_app/src/features/profile/domain/repositories/prfile_repository.dart';
import 'package:social_app/src/features/profile/domain/usecases/delete_post_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_profile_info.dart';
import 'package:social_app/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';

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

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileRemoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  // UseCases
  // -------------------------------(Auth)--------------------------------
  sl.registerLazySingleton(() => UpdateProfileUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfileInfoUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteProfilePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfilePostsUseCase(repository: sl()));

/* --------------------Core-------------------- */
  // -------------------------------(Auth)--------------------------------
  sl.registerLazySingleton<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasourceImpl());
/* --------------------External-------------------- */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
