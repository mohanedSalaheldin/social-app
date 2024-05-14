import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class CommentPostsUseCase {
  HomeRepository repository;
  CommentPostsUseCase({required this.repository});
  call() {
    return repository.comment("", "");
  }
}
