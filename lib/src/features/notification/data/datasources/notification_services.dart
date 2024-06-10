import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
class NotificationService {
  final String serverUrl =
      'https://fcm.googleapis.com/v1/projects/mo-social-app/messages:send';

  Future<String> _getAccessToken() async {

    const clientEmail =
        "fcm-push-notifications-service@mo-social-app.iam.gserviceaccount.com";
    const privateKey =
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC6m9RZjmA3jVwI\nTx+agm/5nScFv9dCaDbmxCg8nOmTvijW4Jy4zPt15sHefwJXnb6jn5zYsyryrHmu\nVNnC0ZGnPvPMH8dcQ/l0gxaoNA0lIeBEUWuAm+lBQAcf5FIn3yGJ90Eq6M1w7lgN\nH/Lk9G9C9R4BN6r19gKMI1rbwj6EdSy0DfH4YASD1I805JpPMZjP3Zy8V4u1n4oS\nvXzKFscGRF2Tqg7L02FVGCrMMFnvahpgtGQPPyG0kKVDpK/IAFBrpySTokPa7pTa\nbKxspF2Gt/Mn4rOu/JSu6v/5YfCHdx+YBWGhERDfwCDqpKJmhzyDhwwPxVSffXcH\nxKUfhTqvAgMBAAECggEAO1aE2itnVhLZsnyygHe8soNx3qanhOLNnmi+oLOGpKfB\npb5Lp4nq5g1IFX+Ol5y9+5qsDc4/OGZ21OP/UK9CIQvoCz8JrkGhJ5btk/PlQCr6\n/M5lIEKzk7+P5Gi+ZRZTPGNGsiXP+fqYPigsHPjLDmASN/HjJ44gNj6hzCKCraxn\nv5u6X1aE8PCHUnooLCQKeklRSj//F7BUqwCNA/iX0aSUcRbsmunUSbZH3qR11J0g\nRPhhHu55Q0/V29ukOvRFekSlW+ePjl1fW+FQc6gagLiXU52/l+f9EaPMWbAMa+B+\nqdsOD2TvGHi7gkhVJ+MV3JQFSoTtwsH48JSJNQhpJQKBgQDitwrD/5xZzh97sTA8\nbihK0rxTD/Luf1HgkyLsmxvWX93SfAH6tUsTBGtj4l8E8Po0UOZ8vSbHjV7W7E2c\n+yOQpijNLUcrpc4mOW3EgayKkws+/v3vwNoNbA61V3P8PbTTLYRL0PQG10K2o4Ko\nZhOoILCxAf8uRWFFFWi1aVLW7QKBgQDSto/XiDEWHMxPEzw+An8PpEFTEGDKGmHH\njeAhHTpd5el2gHGelw7zza4ER+S5JCm1DufdkCX/aUCkuCjKf9uVOu/JM5kLixM6\n108U9wfXRAzQ5xEiR0NYqj2/6VofdM+A8iCH+N9+oaD/PnfSCbxJqIWWbHP7fuYh\nEtCRFZuoiwKBgQCTOQYWrSCc+MtdCX0nYOltXVfKIKtC0Q8cZK/jMf5rwalMjBbE\n9YGhAdey70eA7/OqkXZ7PmG2aElUC/OCo1s/DYelZWe4Il2yWMy9NPAUtNQyvmes\nj3GKEcejXv0EqhWIpSAqE7DD2HmMHLY2IMNXBJN4/rD1HTzDHdn3JEQVKQKBgDS0\n16wY8/ZNA8nvzMzSAQhflLt7SEqlaLnqwhpmXjgoj0pF/KWnsWTImPOXLB4nbotM\njDD+opKNuE67hfCJJNriICKa1nhttESuoKhk1kBBVFdYxQ9m9fCSvNlpPFLL/C+L\n4RlB5l2dflD6RixypPdjwO6MeEJ7ToMNWsA/wGzbAoGAai/KMKPcSKOPwuX7qSWD\nZfXfpwrWjCpos3mYEhUeXj+EBa95qJOXMEKf6encOLwAyB2nkOP8PxPQ2gt/9Dl6\ni97/OzA1BPuozVdc1g0jN16sLJtw5ypcmCpYiZtJgVeL0YGmqs+GQ0yq8xYaIt7K\nP7wNRUV4wxdYHwryZ3zaqz8=\n-----END PRIVATE KEY-----\n";

    final iat = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final exp = iat + 3600;

    // Create a JWT
    final jwt = JWT(
      {
        'iss': clientEmail,
        'scope': 'https://www.googleapis.com/auth/cloud-platform',
        'aud': 'https://oauth2.googleapis.com/token',
        'iat': iat,
        'exp': exp,
      },
    );

    // Sign the JWT with the private key
    final token = jwt.sign(
      RSAPrivateKey(privateKey),
      algorithm: JWTAlgorithm.RS256,
    );

    // Request an access token
    final response = await http.post(
      Uri.parse('https://oauth2.googleapis.com/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion': token,
      },
    );
    

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['access_token'];
    } else {
      throw Exception('Failed to obtain access token: ${response.body}');
    }
  }

  Future<void> sendPushMessage(
      {required String token,
      required String title,
      required String body}) async {
    final accessToken = await _getAccessToken();

    try {
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(
          {
            'message': {
              'token': token,
              'notification': {
                'title': title,
                'body': body,
              },
            },
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Push message sent successfully');
      } else {
        print('Failed to send push message: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error sending push message: $e');
    }
  }
}
