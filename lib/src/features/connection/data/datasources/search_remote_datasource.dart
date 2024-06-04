import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/models/user_info_model.dart';

abstract class ConnectionRemoteDataSource {
  Future<List<UserInfoModel>> searchForUser({required String keyword});
  Stream<List<UserInfoEntity>> getAllUsers();
  Future<Unit> followUnfollowUser(
      {required String currentUserId, required String otherUserId});
}

class ConnectionRemoteDataSourceImpl implements ConnectionRemoteDataSource {
  final FirebaseFirestore firestoreStore = FirebaseFirestore.instance;
  @override
  Future<List<UserInfoModel>> searchForUser({required String keyword}) async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        firestoreStore.collection('users');

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    List<UserInfoModel> allUsers = querySnapshot.docs
        .map((doc) => UserInfoModel.fromJson(doc.data()))
        .toList();

    String lowerCaseKeyword = keyword.toLowerCase();
    List<UserInfoModel> filteredUsers = allUsers.where((user) {
      return user.userName.toLowerCase().contains(lowerCaseKeyword);
    }).toList();

    return filteredUsers;
  }

  @override
  Future<Unit> followUnfollowUser(
      {required String currentUserId, required String otherUserId}) {
    DocumentReference<Map<String, dynamic>> currentUserdoc =
        firestoreStore.collection('users').doc(currentUserId);
    currentUserdoc.get().then((value) {
      if (value.data()!['following'].contains(otherUserId)) {
        currentUserdoc.update({
          'following': FieldValue.arrayRemove([otherUserId])
        });
      } else {
        currentUserdoc.update({
          'following': FieldValue.arrayUnion([otherUserId])
        });
      }
    });
    DocumentReference<Map<String, dynamic>> doc =
        firestoreStore.collection('users').doc(otherUserId);
    doc.get().then((value) {
      if (value.data()!['followers'].contains(currentUserId)) {
        doc.update({
          'followers': FieldValue.arrayRemove([currentUserId])
        });
      } else {
        doc.update({
          'followers': FieldValue.arrayUnion([currentUserId])
        });
      }
    });

    return Future.value(unit);
  }

  @override
  Stream<List<UserInfoEntity>> getAllUsers()  {
    // Stream<List<UserInfoModel>> allUsersStream = const Stream.empty();
    // CollectionReference<Map<String, dynamic>> collectionReference =
    //     firestoreStore.collection('users');
    // collectionReference.snapshots().listen((event) {
    //   allUsersStream = collectionReference.snapshots().map((querySnapshot) {
    //     List<UserInfoModel> users = [];
    //     for (var doc in querySnapshot.docs) {
    //       users.add(UserInfoModel.fromJson(doc.data()));
    //     }
    //     return users;
    //   });
    // });

    // return allUsersStream;

       return firestoreStore
        .collection('users')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              UserInfoModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }


}
