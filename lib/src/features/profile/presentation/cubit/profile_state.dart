part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserInfoEntity userInfoEntity;
  const ProfileLoadedState({required this.userInfoEntity});
}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final Failure failure;
  const ProfileErrorState({required this.failure});
}
