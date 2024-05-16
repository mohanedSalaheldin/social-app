import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class InitalState extends HomeState {}

class HomeAddCommentLoadingState extends HomeState {}

class HomeAddCommentErrorState extends HomeState {}

class HomeAddCommentSuccessState extends HomeState {}

class HomeRemoveCommentLoadingState extends HomeState {}

class HomeRemoveCommentErrorState extends HomeState {}

class HomeRemoveCommentSuccessState extends HomeState {}

class HomeGetCommentLoadingState extends HomeState {}

class HomeGetCommentErrorState extends HomeState {}

class HomeGetCommentSuccessState extends HomeState {}

class HomeLikeOrDislikeLoadingState extends HomeState {}

class HomeLikeOrDislikeErrorState extends HomeState {}

class HomeLikeOrDislikeSuccessState extends HomeState {}
