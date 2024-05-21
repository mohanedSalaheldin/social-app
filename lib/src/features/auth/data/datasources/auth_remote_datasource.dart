import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    required String profileImagePath,
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
    required String profileImagePath,
  }) async {
    print('profileImagePath: $profileImagePath');
    String profileUrl;
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print('*********************(USER CREATED)**********************');
    _uploadProfileImage(
      image: File(profileImagePath),
      userId: userCredential.user!.uid,
    ).then((value) {
      _saveUserDataInFireStore(
          email: email,
          userId: userCredential.user!.uid,
          userName: userName,
          profileImageURL: value);
    });

    return Future.value(unit);
  }

  @override
  Future<void> logout() {
    return _auth.signOut();
  }

// motese12@teat.com
  void _saveUserDataInFireStore(
      {required String userName,
      required String userId,
      required String email,
      required String profileImageURL}) async {
    String token = await FirebaseMessaging.instance.getToken() ?? '';
    await _store.collection('users').doc(userId).set(
      {
        'userId': userId,
        'userName': userName,
        'email': email,
        'profileImageURL': profileImageURL,
        'address': ' ',
        'followers': 0,
        'following': 0,
        'fcmToken': '',
        'bio': '',
      },
    ).then((value) {
      print('*********************(USER DATA UPLOADED)**********************');
    });
  }

  @override
  Future<String> _uploadProfileImage(
      {required File image, required userId}) async {
    // File file = File(path);
    print('*******************************************');
    print(image.path);
    print('*******************************************');
    final extension = image.path.split('/').last;
    final task = _bucket
        .ref()
        .child('$userId/images/profiles/profile.$extension')
        .putFile(image);
    final snapshot = await task.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    print('*********************(IMAGE UPLOADED)**********************');

    return url;
  }
}
