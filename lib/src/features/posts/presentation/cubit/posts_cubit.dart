import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';
import 'package:social_app/src/features/posts/domain/usecases/comment_post_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/get_all_comment_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/like_unlike_post_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/posts_add_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/remove_comment_usecase.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsAddPostUsecase postsAddPostUsecase;
  final PostsLikeOrDisLikePostUseCase postsLikeOrDisLikePostUseCase;
  PostsAddCommentUseCase addCommentUseCase;
  PostsRemoveCommentUseCase removeCommentUseCase;
  PostsGetAllCommentUseCase getAllCommentUseCase;
  PostsCubit({
    required this.postsAddPostUsecase,
    required this.addCommentUseCase,
    required this.removeCommentUseCase,
    required this.getAllCommentUseCase,
    required this.postsLikeOrDisLikePostUseCase,
  }) : super(PostsInitial());

  static PostsCubit get(context) => BlocProvider.of(context);

  void addPost(
      {required UserInfoEntity userInfo,
      required String imagePath,
      required String postCaption}) {
    PostEntity postEntity = PostEntity(
      writerId: userInfo.userId,
      writtenBy: userInfo.userName,
      imageUrl: imagePath == '' ? null : imagePath,
      userProfileImage: userInfo.profileImageURL,
      id: '',
      text: postCaption,
      time: DateTime.now().toString(),
      likes: [],
      comments: 0,
    );
    emit(PostsAddPostLoadingState());
    postsAddPostUsecase
        .call(userID: userInfo.userId, postEntity: postEntity)
        .then((value) {
      emit(PostsAddPostSuccessState());
    }).catchError((e) {
      emit(PostsAddPostErrorState());
    });
  }

  void likeOrDislikePost(
      {required String postId, required String userId}) async {
    print("postId cubit: $postId");
    print("userId cubit: $userId");
    emit(PostsLikeOrDislikeLoadingState());
    Either<Failure, Unit> result = await postsLikeOrDisLikePostUseCase.call(
        postId: postId, userId: userId);
    result.fold(
      (failure) {
        emit(PostsLikeOrDislikeErrorState());
      },
      (_) {
        emit(PostsLikeOrDislikeSuccessState());
      },
    );
  }

  void addComment({required CommentEntity comment}) async {
    emit(PostsAddCommentLoadingState());
    Either<Failure, Unit> result =
        await addCommentUseCase.call(comment: comment);
    result.fold(
      (failure) {
        emit(PostsAddCommentErrorState());
      },
      (_) {
        emit(PostsAddCommentSuccessState());
      },
    );
  }

  void removeComment(
      {required String commentID, required String postId}) async {
    emit(PostsRemoveCommentLoadingState());
    Either<Failure, Unit> result =
        await removeCommentUseCase.call(commentID: commentID, postId: postId);
    result.fold(
      (failure) {
        emit(PostsRemoveCommentErrorState());
      },
      (_) {
        emit(PostsRemoveCommentSuccessState());
      },
    );
  }

  Stream<List<CommentEntity>> _commentList = const Stream.empty();

  Stream<List<CommentEntity>> get commentList => _commentList;

  void getComments({required String postId}) async {
    emit(PostsGetCommentLoadingState());

    Either<Failure, Stream<List<CommentEntity>>> result =
        await getAllCommentUseCase.call(postId: postId);
    result.fold(
      (failure) {
        emit(PostsGetCommentErrorState());
      },
      (stream) {
        _commentList = stream;
        emit(PostsGetCommentSuccessState());
      },
    );
  }
}
