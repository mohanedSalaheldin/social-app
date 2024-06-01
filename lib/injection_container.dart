import 'package:get_it/get_it.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/chat/data/datasoursec/chats_remote_datasource.dart';
import 'package:social_app/src/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:social_app/src/features/chat/domain/repositories/chats_repositories.dart';
import 'package:social_app/src/features/chat/domain/usecases/create_entry_usecase.dart';
import 'package:social_app/src/features/chat/domain/usecases/get_entries_usecase.dart';
import 'package:social_app/src/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:social_app/src/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:social_app/src/features/chat/presentation/cubet/chats_cubit.dart';
import 'package:social_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:social_app/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:social_app/src/features/posts/domain/usecases/comment_post_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/get_all_comment_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/like_unlike_post_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/remove_comment_usecase.dart';
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
      addCommentUseCase: sl(),
      removeCommentUseCase: sl(),
      getAllCommentUseCase: sl(),
      postsLikeOrDisLikePostUseCase: sl(),
      postsAddPostUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => HomeCubit(
      // removeCommentUseCase: sl(),
      // addCommentUseCase: sl(),
      getPostsUseCase: sl(),
      // likeOrDisLikePostUseCase: sl(),
      // likePostsUseCase: sl(),
      // getAllCommentUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ChatsCubit(
      getChatEntriesUseCase: sl(),
      getMessagesUseCase: sl(),
      sendMsgUseCase: sl(),
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
  sl.registerLazySingleton<ChatRepository>(
    () => ChatsRepositoryImpl(
      chatRemoteDatasource: sl(),
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
  // -------------------------------(chats)----------------------------------
  sl.registerLazySingleton(() => CreateEntryUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetChatEntriesUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => SendMsgUseCase(chatRepository: sl()));
  // -------------------------------(Profile)--------------------------------
  sl.registerLazySingleton(() => UpdateProfileUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfileInfoUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteProfilePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfilePostsUseCase(repository: sl()));
  // -------------------------------(Search)--------------------------------
  sl.registerLazySingleton(() => SearchForUserUseCase(repository: sl()));
  // -------------------------------(home)----------------------------------
  sl.registerLazySingleton(() => GetPostsUseCase(repository: sl()));

  // -------------------------------(Posts)--------------------------------
  sl.registerLazySingleton(() => PostsAddPostUsecase(repository: sl()));
  sl.registerLazySingleton(
      () => PostsLikeOrDisLikePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => PostsAddCommentUseCase(repository: sl()));
  sl.registerLazySingleton(() => PostsGetAllCommentUseCase(repository: sl()));
  sl.registerLazySingleton(() => PostsRemoveCommentUseCase(repository: sl()));

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
// ---------------------------------(Chats)----------------------------------
  sl.registerLazySingleton<ChatRemoteDatasource>(
      () => ChatRemoteDatasourceImpl());
  // -------------------------------(Posts)--------------------------------
  sl.registerLazySingleton<PostsRemoteDatasSource>(
      () => PostsRemoteDatasSourceImpl());
/* --------------------External-------------------- */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
