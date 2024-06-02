// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:io';
// import 'package:pointycastle/export.dart';
// import 'package:pointycastle/pointycastle.dart';

// Future<String> getAccessToken() async {
//   // Load the service account credentials JSON file
//   final String serviceAccountJson =
//       await File('serviceAccountKey.json').readAsString();
//   final Map<String, dynamic> serviceAccount = json.decode(serviceAccountJson);

//   // Construct the OAuth 2.0 token URL
//   const String tokenUrl = 'https://oauth2.googleapis.com/token';

//   // Construct the request body
//   final Map<String, String> body = {
//     'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
//     'assertion': generateJwt(
//         serviceAccount['client_email'], serviceAccount['private_key']),
//   };

//   // Send the POST request to get the access token
//   final http.Response response = await http.post(
//     Uri.parse(tokenUrl),
//     body: body,
//   );

//   // Parse and return the access token
//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = json.decode(response.body);
//     return data['access_token'];
//   } else {
//     throw Exception(
//         'Failed to get access token. Status code: ${response.statusCode}');
//   }
// }

// String generateJwt(String email, String privateKey) {
//   final int issuedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//   final int expirationTime = issuedAt + 3600; // Token expires in 1 hour

//   final Map<String, dynamic> claims = {
//     'iss': email,
//     'scope': 'https://www.googleapis.com/auth/firebase.messaging',
//     'aud': 'https://oauth2.googleapis.com/token',
//     'exp': expirationTime,
//     'iat': issuedAt,
//   };

//   final String header = base64Url
//       .encode(utf8.encode(json.encode({'alg': 'RS256', 'typ': 'JWT'})));
//   final String payload = base64Url.encode(utf8.encode(json.encode(claims)));

//   final String data = '$header.$payload';

//   // Sign the JWT using RS256 algorithm
//   final String signature = generateSignature(data, privateKey);

//   return '$data.$signature';
// }

// String generateSignature(String data, String privateKeyPem) {
//   final Parser parser = RSAKeyParser();
//   final RSAPrivateKey privateKey = parser.parse(privateKeyPem) as RSAPrivateKey;
//   final RSASigner signer = RSASigner(SHA256Digest(), '0609608648016503040201');
//   final PrivateKeyParameter<RSAPrivateKey> privateKeyParam =
//       PrivateKeyParameter(privateKey);
//   signer.init(true, privateKeyParam);
//   final Uint8List signature = signer.generateSignature(utf8.encode(data));
//   return base64Url.encode(signature);
// }
