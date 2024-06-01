import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/home/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeGetPostsUseCase getPostsUseCase;

  HomeCubit({required this.getPostsUseCase}) : super(InitalState());

  static HomeCubit get(context) => BlocProvider.of(context);
  Stream<List<PostEntity>> _posts = const Stream.empty();
  Stream<List<PostEntity>> get posts => _posts;

  void getPosts({required String userId}) async {
    Either<Failure, Stream<List<PostEntity>>> result =
        await getPostsUseCase.call(userId: userId);
    result.fold(
      (failure) {
        emit(HomePostsErrorState());
      },
      (posts) {
        print(posts.first.toString());
        _posts = posts;
        emit(HomePostsSuccessState());
      },
    );
  }
}
