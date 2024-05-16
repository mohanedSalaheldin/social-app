import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/features/home/data/models/comment_model.dart';
import 'package:social_app/src/features/home/domain/entities/comment_entity.dart';

abstract class HomeRemoteDataSource {
  Stream<List<PostModel>> getPosts();
  Future<Unit> likeOrDislikePost(
      {required String postId, required String userId});
  Future<Unit> addComment({required CommentEntity comment});
  Future<Unit> removeComment(
      {required String postId, required String commentID});
  Stream<List<CommetModel>> getComments({required String postId});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _bucket = FirebaseStorage.instance;

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
  Future<Unit> addComment({required CommentEntity comment}) {
    CommetModel model = CommetModel(
      comment: comment.comment,
      writerName: comment.writerName,
      writerImageUrl: comment.writerImageUrl,
      time: DateTime.now(),
      postId: comment.postId,
      replayTo: comment.replayTo,
    );
    _store.collection('posts').doc(comment.postId).collection('comments').add(
          model.toJson(),
        );
    return Future.value(unit);
  }

  @override
  Stream<List<CommetModel>> getComments({required String postId}) {
    return _store
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map(
          (event) => event.docs
              .map((doc) => CommetModel.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<Unit> likeOrDislikePost(
      {required String postId, required String userId}) {
    DocumentReference<Map<String, dynamic>> doc =
        _store.collection('posts').doc(postId);
    doc.get().then((value) {
      if (value.data()!['likes'].contains(userId)) {
        doc.update({
          'likes': FieldValue.arrayRemove([userId])
        });
      } else {
        doc.update({
          'likes': FieldValue.arrayUnion([userId])
        });
      }
    });

    return Future.value(unit);
  }

  @override
  Future<Unit> removeComment(
      {required String postId, required String commentID}) {
    _store
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentID)
        .delete();
    return Future.value(unit);
  }
}
