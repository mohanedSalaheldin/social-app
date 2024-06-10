import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/src/core/errors/execptions.dart';
import 'package:social_app/src/features/notification/data/datasources/notification_services.dart';

abstract class NotificationRemoteDataSource {
  Future<Unit> sendPushMessage(
      {required String receiverToken,
      required String title,
      required String body});
  Future<Stream<List<String>>> getAllNotifications({required String userId});
}

class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  @override
  Future<Unit> sendPushMessage(
      {required String receiverToken,
      required String title,
      required String body}) async {
    NotificationService notificationService = NotificationService();

    try {
      await notificationService.sendPushMessage(
        token: receiverToken,
        title: title,
        body: body,
      );
      _updateNotificationByFcmToken(receiverToken, {
        'body': body,
        'time': DateTime.now().toString(),
      });
      return Future.value(unit);
    } catch (e) {
      print('Error sending push message: $e');

      throw ServerExecption();
    }
  }

  Future<void> _updateNotificationByFcmToken(
      String fcmToken, Map<String, dynamic> notificationData) async {
    try {
      // Reference to Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query to find the document by fcmToken
      QuerySnapshot querySnapshot = await firestore
          .collection('users') // Replace with your collection name
          .where('fcmToken', isEqualTo: fcmToken)
          .limit(1) // Assuming fcmToken is unique, we limit to 1
          .get();

      // Check if document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID
        String docId = querySnapshot.docs.first.id;

        // Add notification to the notifications sub-collection
        await firestore
            .collection('users') // Replace with your collection name
            .doc(docId)
            .collection('notifications')
            .add(notificationData);

        print('Notification added successfully');
      } else {
        print('No document found with the specified fcmToken');
      }
    } catch (e) {
      print('Error updating notification: $e');
    }
  }

  @override
  Future<Stream<List<String>>> getAllNotifications(
      {required String userId}) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .snapshots()
        .map(
      (event) {
        return event.docs.map((doc) {
          print('------------------------------------------------------------');
          print(doc.data()['body'].toString());
          print('------------------------------------------------------------');
          return doc.data()['body'].toString();
        }).toList();
      },
    );
  }
}
