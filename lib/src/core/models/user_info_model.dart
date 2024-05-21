import 'package:social_app/src/core/entites/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  UserInfoModel(
      {required super.userId,
      required super.fcmToken,
      required super.userName,
      required super.email,
      required super.profileImageURL,
      required super.address,
      required super.followers,
      required super.following,
      required super.bio});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
        userId: json['userId'],
        fcmToken: json['fcmToken'] ?? '',
        userName: json['userName'],
        email: json['email'],
        profileImageURL: json['profileImageURL'],
        address: json['address'],
        followers: json['followers'],
        following: json['following'],
        bio: json['bio']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'fcmToken': fcmToken,
      'profileImageURL': profileImageURL,
      'address': address,
      'followers': followers,
      'following': following,
      'bio': bio,
    };
  }
}
