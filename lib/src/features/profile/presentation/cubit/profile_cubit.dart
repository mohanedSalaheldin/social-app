import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/domain/usecases/delete_post_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_profile_details_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_profile_info.dart';
import 'package:social_app/src/features/profile/domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileInfoUseCase getProfileInfoUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteProfilePostUseCase deletePostUseCase;
  final GetProfilePostsUseCase getPostsUseCase;
  final GetProfileDetailsUseCase getProfileDetailsUseCase;

  ProfileCubit({
    required this.getProfileInfoUseCase,
    required this.getProfileDetailsUseCase,
    required this.updateProfileUseCase,
    required this.deletePostUseCase,
    required this.getPostsUseCase,
  }) : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  Stream<List<PostEntity>> _posts = const Stream.empty();

  Stream<List<PostEntity>> get posts => _posts;
  UserInfoEntity _userInfo = UserInfoEntity(
    userName: '',
    email: '',
    fcmToken: '',
    profileImageURL: '',
    userId: '',
    address: '',
    followers: [],
    following: [],
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

  Stream<UserInfoEntity> _profileDetails = const Stream.empty();

  Stream<UserInfoEntity> get profileDetails => _profileDetails;

  Future<void> getProfileDetails({required String userId}) async {
    // emit(ProfileInfoLoadingState());
    Either<Failure, Stream<UserInfoEntity>> result =
        await getProfileDetailsUseCase.call(userId: userId);
    result.fold(
      (failure) {
        emit(ProfileGetProfileDetailsErrorState());
      },
      (profileDetailsStream) {
        _profileDetails = profileDetailsStream;
        emit(ProfileGetProfileDetailsSuccessState());
      },
    );
  }

  Future<void> loadUserInfoAndPosts({required String userId}) async {
    emit(ProfileInfoLoadingState());

    final postsResult = await getPostsUseCase.call(userId: userId);
    postsResult.fold(
      (failure) => emit(ProfileInfoErrorState()),
      (postsStream) {
        _posts = postsStream;
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
        loadUserInfoAndPosts(userId: userId);
        // emit(ProfileUpdateInfoSuccessState());
      },
    );
  }

  Future<void> getPosts({
    required String userId,
  }) async {
    Either<Failure, Stream<List<PostEntity>>> result =
        await getPostsUseCase.call(userId: userId);
    result.fold(
      (failure) {},
      (posts) {
        _posts = posts;
        emit(ProfileGetPostsSuccessState());
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
