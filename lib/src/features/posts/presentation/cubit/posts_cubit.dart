import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/features/posts/domain/usecases/posts_add_usecase.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsAddPostUsecase postsAddPostUsecase;
  PostsCubit({required this.postsAddPostUsecase}) : super(PostsInitial());

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
}
