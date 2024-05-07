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

    var startSearch = keyword;
    var endSearch = '$keyword\uf7ff';

    Stream<List<UserInfoModel>> searchUsers = collectionReference
        .where('userName', isGreaterThanOrEqualTo: startSearch)
        .where('userName', isLessThanOrEqualTo: endSearch)
        .snapshots()
        .map((querySnapshot) {
      List<UserInfoModel> users = [];
      for (var doc in querySnapshot.docs) {
        print(doc.data());
        users.add(UserInfoModel.fromJson(doc.data()));
      }
      return users;
    });
    print('-----------------------');
    searchUsers.first.then((value) {
      for (var element in value) {
        print(element.bio);
      }
    });
    // print(searchUsers.first);
    print('-----------------------');
    return searchUsers.first;
  }
}
