import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class LikePostsUseCase {
  HomeRepository repository;
  LikePostsUseCase({required this.repository});
  call() {
    return repository.likePost("");
  }
}
