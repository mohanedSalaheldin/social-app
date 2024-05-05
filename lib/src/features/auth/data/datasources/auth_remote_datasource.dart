import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> emailLogin({required String email, required String password});
  Future<void> logout();
  Future<String> _uploadProfileImage({required File image, required userId});
  User? getUser();
  Future<Unit> emailRegister({
    required String email,
    required String password,
    required String userName,
    File? profileImagePath,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _bucket = FirebaseStorage.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  Stream<User?> auto() {
    return _auth.authStateChanges();
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
    File? profileImagePath,
  }) async {
    var profileUrl;
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (profileImagePath != null) {
      profileUrl = await _uploadProfileImage(
          image: profileImagePath, userId: userCredential.user!.uid);
    }
    _saveUserDataInFireStore(
        userCredential: userCredential,
        userName: userName,
        profileImageURL: profileUrl);

    return Future.value(unit);
  }

  @override
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
        'userId': userCredential.user!.uid,
        'userName': userName ?? userCredential.user!.displayName,
        'email': userCredential.user!.email,
        'profileImageURL': profileImageURL,
        'address': ' ',
        'followers': 0,
        'following': 0,
        'bio': '',
      },
    );
  }

  @override
  Future<String> _uploadProfileImage(
      {required File image, required userId}) async {
    // File file = File(path);
    final extension = image.path.split('/').last.split('.').last;
    final task = _bucket
        .ref()
        .child('$userId/images/profiles/profile.$extension')
        .putFile(image);
    final snapshot = await task.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
/**
 {
      'userId': userId,
      'userName': userName,
      'email': email,
      'profileImageURL': profileImageURL,
      'address': address,
      'followers': followers,
      'following': following,
      'bio': bio,
    }
 */