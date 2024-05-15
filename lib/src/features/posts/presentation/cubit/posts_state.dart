part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsAddPostLoadingState extends PostsState {}

class PostsAddPostSuccessState extends PostsState {}

class PostsAddPostErrorState extends PostsState {}
