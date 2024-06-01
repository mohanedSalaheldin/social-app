import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/models/post_model.dart';
import 'package:social_app/src/features/posts/data/models/comment_model.dart';

abstract class HomeRemoteDataSource {
  Stream<List<PostModel>> getPosts({required String userId});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _bucket = FirebaseStorage.instance;

  @override
  Stream<List<PostModel>> getPosts({required String userId}) {
    return _store
        .collection('posts')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              PostModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }
}
