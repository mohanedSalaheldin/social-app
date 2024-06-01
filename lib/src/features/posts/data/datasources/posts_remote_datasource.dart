import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/features/posts/data/models/comment_model.dart';

abstract class PostsRemoteDatasSource {
  Future<Unit> addPost({required String userID, required PostModel postModel});
  Future<Unit> likeOrDislikePost(
      {required String postId, required String userId});

  Future<Unit> addComment({required CommentModel comment});
  Future<Unit> removeComment(
      {required String postId, required String commentID});
  Stream<List<CommentModel>> getComments({required String postId});
}

class PostsRemoteDatasSourceImpl implements PostsRemoteDatasSource {
  final FirebaseStorage _bucket = FirebaseStorage.instance;

  final FirebaseFirestore _store = FirebaseFirestore.instance;
  @override
  Future<Unit> addPost(
      {required String userID, required PostModel postModel}) async {
    final value = await _store.collection('posts').add({});
    String imageURL = '';
    if (postModel.imageUrl != null) {
      imageURL = await _uploadProfileImage(
          image: postModel.imageUrl!, userId: userID, postID: value.id);
    }
    Map<String, dynamic> modifiedMap = postModel.toJson();
    modifiedMap['imageUrl'] = imageURL;
    modifiedMap['id'] = value.id;
    _store.collection('posts').doc(value.id).set(modifiedMap);

    return Future.value(unit);
  }

  Future<String> _uploadProfileImage(
      {required String image, required userId, required String postID}) async {
    // File file = File(path);
    final extension = image.split('/').last.split('.').last;
    final task = _bucket
        .ref()
        .child('$userId/images/posts/post_image_$postID.$extension')
        .putFile(File(image));
    final snapshot = await task.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    print('--------------------------------');
    print(url);
    print('--------------------------------');
    return url;
  }

  @override
  Future<Unit> likeOrDislikePost(
      {required String postId, required String userId}) {
    print("postId: $postId");
    print("userId: $userId");
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
  Future<Unit> addComment({required CommentModel comment}) {
    CollectionReference<Map<String, dynamic>> collection =
        _store.collection('posts').doc(comment.postId).collection('comments');
    _store
        .collection('posts')
        .doc(comment.postId)
        .update({'comments': FieldValue.increment(1)});
    collection.add(comment.toJson());

    return Future.value(unit);
  }

  @override
  Stream<List<CommentModel>> getComments({required String postId}) {
    return _store
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map(
          (event) => event.docs
              .map((doc) => CommentModel.fromJson(doc.data()))
              .toList(),
        );
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
// userId/images/profiles/profile