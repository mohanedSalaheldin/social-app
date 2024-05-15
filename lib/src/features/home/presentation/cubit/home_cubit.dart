import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/models/post_model.dart';

import 'package:social_app/src/features/home/domain/usecasese/comment_post_usecase.dart';
import 'package:social_app/src/features/home/domain/usecasese/get_posts_usecase.dart';
import 'package:social_app/src/features/home/domain/usecasese/like_post_usecase.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  CommentPostsUseCase commentPostsUseCase;
  GetPostsUseCase getPostsUseCase;
  LikePostsUseCase likePostsUseCase;

  HomeCubit({
    required this.commentPostsUseCase,
    required this.getPostsUseCase,
    required this.likePostsUseCase,
  }) : super(InitalState());
  static HomeCubit get(context) => BlocProvider.of(context);

  Stream<List<PostModel>> getPosts() {
    return getPostsUseCase.call();
  }
}
