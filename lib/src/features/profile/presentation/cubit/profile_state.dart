part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileInfoSucessState extends ProfileState {
  final UserInfoEntity userInfoEntity;
  const ProfileInfoSucessState({required this.userInfoEntity});
}

class ProfileInfoLoadingState extends ProfileState {}

class ProfileInfoErrorState extends ProfileState {
  final Failure failure;
  const ProfileInfoErrorState({required this.failure});
}

class ProfileUpdateInfoSuccessState extends ProfileState {}

class ProfileUpdateInfoLoadingState extends ProfileState {}

class ProfileUpdateInfoErrorState extends ProfileState {
  final Failure failure;
  const ProfileUpdateInfoErrorState({required this.failure});
}

class ProfileGetPostsSuccessState extends ProfileState {
  final List<PostEntity> posts;

  const ProfileGetPostsSuccessState({required this.posts});
}

class ProfileGetPostsLoadingState extends ProfileState {}

class ProfileGetPostsErrorState extends ProfileState {
  final Failure failure;
  const ProfileGetPostsErrorState({required this.failure});
}

class ProfileDeletePostSuccessState extends ProfileState {}

class ProfileDeletePostLoadingState extends ProfileState {}

class ProfileDeletePostErrorState extends ProfileState {
  final Failure failure;
  const ProfileDeletePostErrorState({required this.failure});
}
