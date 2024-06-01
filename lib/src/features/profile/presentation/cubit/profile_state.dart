part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileInfoSucessState extends ProfileState {}

class ProfileInfoLoadingState extends ProfileState {}

class ProfileInfoErrorState extends ProfileState {}

class ProfileUpdateInfoSuccessState extends ProfileState {}

class ProfileUpdateInfoLoadingState extends ProfileState {}

class ProfileUpdateInfoErrorState extends ProfileState {}

class ProfileGetPostsSuccessState extends ProfileState {

  // final List<PostEntity> posts;

  // const ProfileGetPostsSuccessState(this.posts);

  // @override
  // List<Object> get props => [posts];
}

class ProfileGetPostsLoadingState extends ProfileState {}

class ProfileGetPostsErrorState extends ProfileState {}

class ProfileDeletePostSuccessState extends ProfileState {}

class ProfileDeletePostLoadingState extends ProfileState {}

class ProfileDeletePostErrorState extends ProfileState {}
