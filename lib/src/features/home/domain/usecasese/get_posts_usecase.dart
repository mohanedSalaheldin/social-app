import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/features/home/domain/repositories/home_repository.dart';

class GetPostsUseCase {
  HomeRepository repository;
  GetPostsUseCase({required this.repository});
  Stream<List<PostModel>> call() {
    return repository.getPosts();
  }
}
