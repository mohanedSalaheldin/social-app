import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/features/home/domain/entities/comment_entity.dart';

import 'package:social_app/src/features/home/domain/usecases/comment_post_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/get_all_comment_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/like_unlike_post_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/remove_comment_usecase.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeAddCommentUseCase addCommentUseCase;
  HomeRemoveCommentUseCase removeCommentUseCase;
  HomeGetAllCommentUseCase getAllCommentUseCase;
  HomeLikeOrDisLikePostUseCase likeOrDisLikePostUseCase;
  GetPostsUseCase getPostsUseCase;
  // HomeLikeOrDisLikePostUseCase likePostsUseCase;

  HomeCubit({
    required this.likeOrDisLikePostUseCase,
    required this.removeCommentUseCase,
    required this.getAllCommentUseCase,
    required this.addCommentUseCase,
    required this.getPostsUseCase,
    // required this.likePostsUseCase,
  }) : super(InitalState());
  static HomeCubit get(context) => BlocProvider.of(context);

  Stream<List<PostModel>> getPosts() {
    return getPostsUseCase.call();
  }

  void addComment({required CommentEntity comment}) async {
    emit(HomeAddCommentLoadingState());
    Either<Failure, Unit> result =
        await addCommentUseCase.call(comment: comment);
    result.fold(
      (failure) {
        emit(HomeAddCommentErrorState());
      },
      (_) {
        emit(HomeAddCommentSuccessState());
      },
    );
  }

  void removeComment(
      {required String commentID, required String postId}) async {
    emit(HomeRemoveCommentLoadingState());
    Either<Failure, Unit> result =
        await removeCommentUseCase.call(commentID: commentID, postId: postId);
    result.fold(
      (failure) {
        emit(HomeRemoveCommentErrorState());
      },
      (_) {
        emit(HomeRemoveCommentSuccessState());
      },
    );
  }

  Future<Stream<List<CommentEntity>>> getComments(
      {required String postId}) async {
    emit(HomeGetCommentLoadingState());
    Stream<List<CommentEntity>> comments =
        const Stream<List<CommentEntity>>.empty();
    Either<Failure, Stream<List<CommentEntity>>> result =
        await getAllCommentUseCase.call(postId: postId);
    result.fold(
      (failure) {
        emit(HomeGetCommentErrorState());
      },
      (stream) {
        comments = stream;
        emit(HomeGetCommentSuccessState());
      },
    );
    comments.listen((value) {
      print(value.length);
      for (var element in value) {
        print(element.comment);
      }
    });
    return comments;
  }

  void likeOrDislikePost(
      {required String postId, required String userId}) async {
    print("postId cubit: $postId");
    print("userId cubit: $userId");
    emit(HomeLikeOrDislikeLoadingState());
    Either<Failure, Unit> result =
        await likeOrDisLikePostUseCase.call(postId: postId, userId: userId);
    result.fold(
      (failure) {
        emit(HomeLikeOrDislikeErrorState());
      },
      (_) {
        emit(HomeLikeOrDislikeSuccessState());
      },
    );
  }
}
