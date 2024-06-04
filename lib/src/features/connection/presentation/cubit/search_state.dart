part of 'search_cubit.dart';

abstract class ConnectionsState extends Equatable {
  const ConnectionsState();

  @override
  List<Object> get props => [];
}

class ConnectionInitial extends ConnectionsState {}

class ConnectionSearchForUserLoadingState extends ConnectionsState {}

class ConnectionSearchForUserSuccessState extends ConnectionsState {}

class ConnectionSearchForUserErrorState extends ConnectionsState {}

class ConnectionFollowUnfollowUsersLoadingState extends ConnectionsState {}

class ConnectionFollowUnfollowUsersSuccessState extends ConnectionsState {}

class ConnectionFollowUnfollowUsersErrorState extends ConnectionsState {}

class ConnectionGetAllUsersLoadingState extends ConnectionsState {}

class ConnectionGetAllUsersSuccessState extends ConnectionsState {}

class ConnectionGetAllUsersErrorState extends ConnectionsState {}
