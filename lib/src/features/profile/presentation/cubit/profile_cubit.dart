import 'dart:async';

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
  final DeleteProfilePostUseCase deletePostUseCase;
  final GetProfilePostsUseCase getPostsUseCase;

  ProfileCubit({
    required this.getProfileInfoUseCase,
    required this.updateProfileUseCase,
    required this.deletePostUseCase,
    required this.getPostsUseCase,
  }) : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  List<PostEntity> _posts = [];

  List<PostEntity> get posts => _posts;
  UserInfoEntity _userInfo = UserInfoEntity(
    userName: '',
    email: '',
    fcmToken: '',
    profileImageURL: '',
    userId: '',
    address: '',
    followers: 0,
    following: 0,
    bio: '',
  );

  UserInfoEntity get userInfo => _userInfo;

  void getProfileInfo({required String userId}) async {
    emit(ProfileInfoLoadingState());
    Either<Failure, UserInfoEntity> result =
        await getProfileInfoUseCase.call(userId: userId);
    result.fold(
      (failure) {
        emit(ProfileInfoErrorState());
      },
      (userInfoEntity) {
        _userInfo = userInfoEntity;
        emit(ProfileInfoSucessState());
      },
    );
  }

  void updateProfileInfo(
      {required String userId,
      required UserInfoEntity model,
      required String oldImageUrl}) async {
    emit(ProfileUpdateInfoLoadingState());
    Either<Failure, Unit> result = await updateProfileUseCase.call(
        userId: userId, model: model, oldImageUrl: _userInfo.profileImageURL);
    result.fold(
      (failure) {
        emit(ProfileUpdateInfoErrorState());
      },
      (_) {
        getProfileInfo(userId: userId);
        // emit(ProfileUpdateInfoSuccessState());
      },
    );
  }

  void getPosts({
    required String userId,
  }) async {
    emit(ProfileGetPostsLoadingState());
    Either<Failure, Stream<List<PostEntity>>> result =
        await getPostsUseCase.call(
      userId: userId,
    );
    result.fold(
      (failure) {
        print('_-------------------(in cubit)-----------------------------');
        emit(ProfileGetPostsErrorState());
        print('_-------------------(in cubit)-----------------------------');
      },
      (posts) {
        posts.listen(
          (posts) {
            _posts = posts;
            emit(ProfileGetPostsSuccessState());
          },
        );
      },
    );
  }

  void deletePost({required String userId, required String postId}) async {
    emit(ProfileDeletePostLoadingState());
    Either<Failure, Unit> result =
        await deletePostUseCase.call(userId: userId, postId: postId);
    result.fold(
      (failure) {
        emit(ProfileDeletePostErrorState());
      },
      (_) {
        emit(ProfileDeletePostSuccessState());
      },
    );
  }
}
