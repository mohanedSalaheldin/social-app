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

class PostsLikeOrDislikeLoadingState extends PostsState {}

class PostsLikeOrDislikeErrorState extends PostsState {}

class PostsLikeOrDislikeSuccessState extends PostsState {}

class PostsAddCommentLoadingState extends PostsState {}

class PostsAddCommentErrorState extends PostsState {}

class PostsAddCommentSuccessState extends PostsState {}

class PostsRemoveCommentLoadingState extends PostsState {}

class PostsRemoveCommentErrorState extends PostsState {}

class PostsRemoveCommentSuccessState extends PostsState {}

class PostsGetCommentLoadingState extends PostsState {}

class PostsGetCommentErrorState extends PostsState {}

class PostsGetCommentSuccessState extends PostsState {}
