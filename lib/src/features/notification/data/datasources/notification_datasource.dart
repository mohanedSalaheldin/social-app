import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/src/core/errors/execptions.dart';
import 'package:social_app/src/features/notification/data/datasources/notification_services.dart';

abstract class NotificationRemoteDataSource {
  Future<Unit> sendPushMessage(
      {required String receiverToken,
      required String title,
      required String body});
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
      return Future.value(unit);
    } catch (e) {
      print('Error sending push message: $e');

      throw ServerExecption();
    }
  }
}
