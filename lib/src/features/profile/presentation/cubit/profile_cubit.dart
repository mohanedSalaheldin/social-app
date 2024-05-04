import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/domain/usecases/delete_post_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_profile_info.dart';
import 'package:social_app/src/features/profile/domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileInfoUseCase getProfileInfoUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final DeletePostUseCase deletePostUseCase;
  final GetPostsUseCase getPostsUseCase;

  ProfileCubit({
    required this.getProfileInfoUseCase,
    required this.updateProfileUseCase,
    required this.deletePostUseCase,
    required this.getPostsUseCase,
  }) : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  void getProfileInfo({required String userId}) async {
    emit(ProfileInfoLoadingState());
    Either<Failure, UserInfoEntity> result =
        await getProfileInfoUseCase.call(userId: userId);
    result.fold(
      (failure) {
        emit(ProfileInfoErrorState(failure: failure));
      },
      (userInfoEntity) {
        emit(ProfileInfoSucessState(userInfoEntity: userInfoEntity));
      },
    );
  }

  void updateProfileInfo(
      {required String userId, required UserInfoEntity model}) async {
    emit(ProfileUpdateInfoLoadingState());
    Either<Failure, Unit> result =
        await updateProfileUseCase.call(userId: userId, model: model);
    result.fold(
      (failure) {
        emit(ProfileUpdateInfoErrorState(failure: failure));
      },
      (_) {
        emit(ProfileUpdateInfoSuccessState());
      },
    );
  }

  void getPosts({
    required String userId,
  }) async {
    emit(ProfileGetPostsLoadingState());
    Either<Failure, List<PostEntity>> result = await getPostsUseCase.call(
      userId: userId,
    );
    result.fold(
      (failure) {
        emit(ProfileGetPostsErrorState(failure: failure));
      },
      (posts) {
        emit(ProfileGetPostsSuccessState(posts: posts));
      },
    );
  }

  void deletePost({required String userId, required String postId}) async {
    emit(ProfileDeletePostLoadingState());
    Either<Failure, Unit> result =
        await deletePostUseCase.call(userId: userId, postId: postId);
    result.fold(
      (failure) {
        emit(ProfileDeletePostErrorState(failure: failure));
      },
      (_) {
        emit(ProfileDeletePostSuccessState());
      },
    );
  }
}
