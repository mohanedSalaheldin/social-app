import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/core/models/user_info_model.dart';

abstract class ProfileRemoteDatasource {
  Future<Unit> deletePost({required String postId});
  Future<List<PostModel>> getPosts({required String userId});
  Future<UserInfoModel> getProfileInfo({required String userId});
  Future<Unit> updateProfile({required String userId});
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final FirebaseFirestore firestoreStore = FirebaseFirestore.instance;
  @override
  Future<Unit> deletePost({required String postId}) {
    /// Deletes a post with the given [postId].
    ///
    /// Throws an [UnimplementedError] if the function is not implemented.
    ///
    /// Parameters:
    ///   - [postId]: The ID of the post to be deleted.
    ///
    /// Returns:
    ///   A [Future] that completes with a [Unit] when the post is successfully deleted.
    // TODO: implement deletePost
    throw UnimplementedError();
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
        posts.add(PostModel.fromJson(element.data()));
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
  Future<Unit> updateProfile({required String userId}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
