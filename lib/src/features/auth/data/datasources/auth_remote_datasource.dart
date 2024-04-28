import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> emailLogin({required String email, required String password});
  Future<void> logout();
  User? getUser();
  Future<Unit> emailRegister({
    required String email,
    required String password,
    required String userName,
    String? prfileImagePath,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _bucket = FirebaseStorage.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  Stream<User?> auto() {
    return _auth.authStateChanges().asBroadcastStream();
  }

  @override
  User? getUser() {
    return _auth.currentUser;
  }

  @override
  Future<Unit> emailLogin(
      {required String email, required String password}) async {
    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    debugPrint(user.toString());
    return Future.value(unit);
  }

  @override
  Future<Unit> emailRegister({
    required String email,
    required String password,
    required String userName,
    String? prfileImagePath,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _saveUserDataInFireStore(
        userCredential: userCredential,
        userName: userName,
        profileImageURL: prfileImagePath);

    return Future.value(unit);
  }

  Future<void> logout() {
    return _auth.signOut();
  }

  void _saveUserDataInFireStore(
      {required UserCredential userCredential,
      String? userName,
      String? profileImageURL}) async {
    await _store
        .collection('users')
        .doc(
          userCredential.user!.uid,
        )
        .set(
      {
        'uID': userCredential.user!.uid,
        'username': userName ?? userCredential.user!.displayName,
        'email': userCredential.user!.email,
        'profileImageURL': profileImageURL
        //     'prfileImagePath'

        //       required String email,
        // required String password,
        // required String userName,
        // String? prfileImagePath,
      },
    );
  }
}
