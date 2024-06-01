import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class InitalState extends HomeState {}

class HomePostsSuccessState extends HomeState {}

class HomePostsLoadingState extends HomeState {}

class HomePostsErrorState extends HomeState {}
