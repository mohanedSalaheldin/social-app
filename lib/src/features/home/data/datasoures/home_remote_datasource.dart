import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/models/post_model.dart';

abstract class HomeRemoteDataSource {
  Stream<List<PostModel>> getPosts();
  void likePost(String postId);
  void comment(String postId, String comment);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _bucket = FirebaseStorage.instance;
  @override
  void comment(String postId, String comment) {
    // TODO: implement comment
  }

  @override
  Stream<List<PostModel>> getPosts() {
    return _store
        .collection('users')
        .doc('Lw6kL5VqyTWIgMxuAN9dNnAGRZz1')
        .collection('posts')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              PostModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
    //     .listen((event) {
    //   for (var element in event.docs) {
    //     print(element.data());
    //   }
    // });
    // .snapshots().
    // .map((snapShot) => snapShot.docs
    //     .map((document) => PostModel.fromJson(document.data()))
    //     .toList());
    // return Stream.empty();
// .withConverter<PostModel>(
//           fromFirestore: (snapshot, options) =>
//               PostModel.fromJson(snapshot.data()!),
//           toFirestore: (value, options) => value.toJson(),
//         )
    // .map((event) => PostModel.fromJson(event.data()!));
  }

  @override
  void likePost(String postId) {
    // TODO: implement likePost
  }
}
