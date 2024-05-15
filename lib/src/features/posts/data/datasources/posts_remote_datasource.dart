import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/src/core/models/post_model.dart';

abstract class PostsRemoteDatasSource {
  Future<Unit> addPost({required String userID, required PostModel postModel});
}

class PostsRemoteDatasSourceImpl implements PostsRemoteDatasSource {
  final FirebaseStorage _bucket = FirebaseStorage.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<Unit> addPost(
      {required String userID, required PostModel postModel}) async {
    final value = await firestore
        .collection('users')
        .doc(userID)
        .collection('posts')
        .add({});
    String imageURL = '';
    if (postModel.imageUrl != null) {
      imageURL = await _uploadProfileImage(
          image: postModel.imageUrl!, userId: userID, postID: value.id);
    }
    Map<String, dynamic> modifiedMap = postModel.toJson();
    modifiedMap['imageUrl'] = imageURL;
    modifiedMap['id'] = value.id;
    firestore
        .collection('users')
        .doc(userID)
        .collection('posts')
        .doc(value.id)
        .set(modifiedMap);

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
}
// userId/images/profiles/profile