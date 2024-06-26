class UserInfoEntity {
  final String userId;
  final String fcmToken;
  final String userName;
  final String email;
  final String profileImageURL;
  final String address;
  final List<String> followers;
  final List<String> following;
  final String bio;

  UserInfoEntity(
      {required this.userId,
      required this.fcmToken,
      required this.userName,
      required this.email,
      required this.profileImageURL,
      required this.address,
      required this.followers,
      required this.following,
      required this.bio});
}
