import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/src/core/models/user_info_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<UserInfoModel>> searchForUser({required String keyword});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
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
}
