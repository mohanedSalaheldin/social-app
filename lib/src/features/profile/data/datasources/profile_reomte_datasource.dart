import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/execptions.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/core/models/user_info_model.dart';

abstract class ProfileRemoteDatasource {
  Future<Unit> deletePost({required String postId, required String userId});
  Future<List<PostModel>> getPosts({required String userId});
  Future<UserInfoModel> getProfileInfo({required String userId});
  Future<Unit> updateProfile(
      {required String userId, required UserInfoModel model});
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
  Future<List<PostModel>> getPosts({required String userId}) {
    List<PostModel> posts = [];
    firestoreStore
        .collection('users')
        .doc(userId)
        .collection('posts')
        .get()
        .then((value) {
      for (var element in value.docs) {
        print(
            '-----------------------(in datasource)-----------------------------');
        print(element.data());
        print('----------------------------------------------------');
        // posts.add(PostModel.fromJson(element.data()));
      }
    });
    return Future.value(posts);
  }

  @override
  Future<UserInfoModel> getProfileInfo({required String userId}) async {
    DocumentSnapshot documentSnapshot =
        await firestoreStore.collection('users').doc(userId).get();
    print(
        '-----------------------(in datasource)-----------------------------');
    print(documentSnapshot.data());
    print('----------------------------------------------------');
    UserInfoModel userInfoModel = UserInfoModel.fromJson({});
    return Future.value(userInfoModel);
  }

  @override
  Future<Unit> updateProfile(
      {required String userId, required UserInfoModel model}) {
    try {
      firestoreStore.collection('users').doc(userId).update(model.toJson());
      return Future.value(unit);
    } on FirebaseException {
      throw (ServerExecption());
    }
  }
}
