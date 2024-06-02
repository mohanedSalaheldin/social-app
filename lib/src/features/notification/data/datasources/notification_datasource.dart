import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/src/core/errors/execptions.dart';

abstract class NotificationDataSource {
  Future<Unit> sendPushMessage(
      {required String receiverToken,
      required String title,
      required String body});
}

class NotificationDataSourceImpl extends NotificationDataSource {
  @override
  Future<Unit> sendPushMessage(
      {required String receiverToken,
      required String title,
      required String body}) async {
    String serverToken = 'AIzaSyDHse-pwiJt-OTauLn0SX80xwJCL6dDmg8';
    Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
            },
            'to': receiverToken,
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Push message sent successfully');
      } else {
        print('Failed to send push message: ${response.statusCode}');

        throw ServerExecption();
      }
      return Future.value(unit);
    } catch (e) {
      print('Error sending push message: $e');

      throw ServerExecption();
    }
  }
}
