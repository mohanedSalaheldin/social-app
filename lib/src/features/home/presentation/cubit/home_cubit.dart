import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/features/posts/domain/usecases/comment_post_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/get_all_comment_usecase.dart';
import 'package:social_app/src/features/home/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/like_unlike_post_usecase.dart';
import 'package:social_app/src/features/posts/domain/usecases/remove_comment_usecase.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_state.dart';
import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';

class HomeCubit extends Cubit<HomeState> {
  
  // HomeLikeOrDisLikePostUseCase likeOrDisLikePostUseCase;
  GetPostsUseCase getPostsUseCase;
  // HomeLikeOrDisLikePostUseCase likePostsUseCase;

  HomeCubit({
    // required this.likeOrDisLikePostUseCase,
    // required this.removeCommentUseCase,
    // required this.getAllCommentUseCase,
    // required this.addCommentUseCase,
    required this.getPostsUseCase,
    // required this.likePostsUseCase,
  }) : super(InitalState());
  static HomeCubit get(context) => BlocProvider.of(context);

  Stream<List<PostModel>> getPosts() {
    return getPostsUseCase.call();
  }


}
