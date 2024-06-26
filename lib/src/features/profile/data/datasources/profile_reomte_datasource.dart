import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/src/core/errors/execptions.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/core/models/user_info_model.dart';

abstract class ProfileRemoteDatasource {
  Future<Unit> deletePost({required String postId, required String userId});
  Stream<List<PostModel>> getPosts({required String userId});
  Future<UserInfoModel> getProfileInfo({required String userId});
  Future<Stream<UserInfoModel>> getProfileDetails({required String userId});
  Future<Unit> updateProfile(
      {required String userId,
      required UserInfoModel model,
      required String oldImageUrl});
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final FirebaseFirestore firestoreStore = FirebaseFirestore.instance;
  @override
  Future<Unit> deletePost({required String postId, required String userId}) {
    try {
      firestoreStore
          .collection('users')
          .doc(userId)
          .collection('posts')
          .doc(postId)
          .delete();
      return Future.value(unit);
    } on FirebaseException {
      throw (ServerExecption());
    }
  }

  @override
  Stream<List<PostModel>> getPosts({
    required String userId,
  }) {
    // List<PostModel> posts = [];
    CollectionReference<Map<String, dynamic>> collectionReference =
        firestoreStore.collection('posts');
    return collectionReference.snapshots().map((querySnapshot) {
      List<PostModel> posts = [];
      for (var doc in querySnapshot.docs) {
        // print(doc.data());
        if (doc.data()['writerId'] == userId) {
          print(doc.data());
          posts.add(PostModel.fromJson(doc.data()));
        }
      }
      return posts;
    });
  }

  @override
  Future<UserInfoModel> getProfileInfo({required String userId}) async {
    DocumentSnapshot documentSnapshot =
        await firestoreStore.collection('users').doc(userId).get();
    UserInfoModel userInfoModel =
        UserInfoModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    return Future.value(userInfoModel);
  }

  @override
  Future<Unit> updateProfile(
      {required String userId,
      required UserInfoModel model,
      required String oldImageUrl}) async {
    try {
      if (oldImageUrl != model.profileImageURL) {
        final extension = model.profileImageURL.split('/').last.split('.').last;
        final task = FirebaseStorage.instance
            .ref()
            .child('$userId/images/profiles/profile.$extension')
            .putFile(File(model.profileImageURL));
        final snapshot = await task.whenComplete(() => null);
        final url = await snapshot.ref.getDownloadURL();
        model = UserInfoModel(
            userId: model.userId,
            userName: model.userName,
            fcmToken: model.fcmToken,
            email: model.email,
            profileImageURL: url,
            address: model.address,
            followers: model.followers,
            following: model.following,
            bio: model.bio);
      }
      firestoreStore.collection('users').doc(userId).update(model.toJson());
      return Future.value(unit);
    } on FirebaseException {
      throw (ServerExecption());
    }
  }

  @override
  Future<Stream<UserInfoModel>> getProfileDetails(
      {required String userId}) async {
   return firestoreStore.collection('users').doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserInfoModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    });
  }
}
