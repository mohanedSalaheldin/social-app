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
import 'package:social_app/src/features/connection/domain/usecases/follow_unfollow_user_usecase.dart';
import 'package:social_app/src/features/connection/domain/usecases/get_all_users_usecase.dart';
import 'package:social_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:social_app/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:social_app/src/features/notification/data/datasources/notification_datasource.dart';
import 'package:social_app/src/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:social_app/src/features/notification/domain/repositories/notification_repository.dart';
import 'package:social_app/src/features/notification/domain/usecases/get_all_notification.dart';
import 'package:social_app/src/features/notification/domain/usecases/notification_send_usecase.dart';
import 'package:social_app/src/features/notification/presentation/cubit/notification_cubit.dart';
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
import 'package:social_app/src/features/profile/domain/usecases/get_profile_details_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_profile_info.dart';
import 'package:social_app/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_app/src/features/connection/data/datasources/search_remote_datasource.dart';
import 'package:social_app/src/features/connection/data/repositories/search_repository_impl.dart';
import 'package:social_app/src/features/connection/domain/repositories/search_repository.dart';
import 'package:social_app/src/features/connection/domain/usecases/search_for_user_usecase.dart';
import 'package:social_app/src/features/connection/presentation/cubit/search_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
/* --------------------Features-------------------- */
// Quates
  // Bloc
  sl.registerFactory(() => ProfileCubit(
      deletePostUseCase: sl(),
      getProfileDetailsUseCase: sl(),
      getPostsUseCase: sl(),
      getProfileInfoUseCase: sl(),
      updateProfileUseCase: sl()));
  sl.registerFactory(() => ConnectionCubit(
      searchForUserUseCase: sl(),
      getAllUsersUsecase: sl(),
      followUnfollowUserUseCase: sl()));
  sl.registerFactory(() => PostsCubit(
      addCommentUseCase: sl(),
      removeCommentUseCase: sl(),
      getAllCommentUseCase: sl(),
      postsLikeOrDisLikePostUseCase: sl(),
      postsAddPostUsecase: sl()));

  sl.registerFactory(() => HomeCubit(getPostsUseCase: sl()));

  sl.registerFactory(() => ChatsCubit(
      getChatEntriesUseCase: sl(),
      getMessagesUseCase: sl(),
      sendMsgUseCase: sl()));
  sl.registerFactory(() => NotificationCubit(
      notificationSendUsecase: sl(), getAllNotificationsUsecase: sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(() =>
      ProfileRepositoryImpl(profileRemoteDatasource: sl(), networkInfo: sl()));
  // -------------------------------(connections)-----------------------------------

  sl.registerLazySingleton<ConnectionRepository>(() => ConnectionRepositoryImpl(
      connectionRemoteDataSource: sl(), networkInfo: sl()));
  // -------------------------------(chat)-----------------------------------

  sl.registerLazySingleton<ChatRepository>(
      () => ChatsRepositoryImpl(chatRemoteDatasource: sl(), networkInfo: sl()));
  // -------------------------------(home)-----------------------------------
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRpositoryImpl(homeRemoteDataSource: sl(), networkInfo: sl()));
  // -------------------------------(Posts)-----------------------------------

  sl.registerLazySingleton<PostsRepository>(() =>
      PostsRepositoryImpl(postsRemoteDataSource: sl(), networkInfo: sl()));
  // -------------------------------(notification)-----------------------------------

  sl.registerLazySingleton<NotificationRepository>(() =>
      NotificationRepositoryImpl(
          notificationDataSource: sl(), networkInfo: sl()));

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
  sl.registerLazySingleton(() => GetProfileDetailsUseCase(repository: sl()));
  // -------------------------------(connections)--------------------------------
  sl.registerLazySingleton(() => SearchForUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllUsersUsecase(repository: sl()));
  sl.registerLazySingleton(() => FollowUnfollowUserUseCase(repository: sl()));

  // -------------------------------(home)----------------------------------
  sl.registerLazySingleton(() => HomeGetPostsUseCase(repository: sl()));
  // -------------------------------(notification)----------------------------------
  sl.registerLazySingleton(() => NotificationSendUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetAllNotificationsUsecase(repository: sl()));

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
  sl.registerLazySingleton<ConnectionRemoteDataSource>(
      () => ConnectionRemoteDataSourceImpl());
  // -------------------------------(home)-----------------------------------
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl());
// ---------------------------------(Chats)----------------------------------
  sl.registerLazySingleton<ChatRemoteDatasource>(
      () => ChatRemoteDatasourceImpl());
  // -------------------------------(Posts)--------------------------------
  sl.registerLazySingleton<PostsRemoteDatasSource>(
      () => PostsRemoteDatasSourceImpl());
  // -------------------------------(notification)--------------------------------
  sl.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl());
/* --------------------External-------------------- */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
