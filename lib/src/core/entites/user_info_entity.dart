class UserInfoEntity {
  final String userId;
  final String userName;
  final String email;
  final String profileImageURL;
  final String address;
  final int followers;
  final int following;
  final String bio;

  UserInfoEntity(
      {required this.userId,
      required this.userName,
      required this.email,
      required this.profileImageURL,
      required this.address,
      required this.followers,
      required this.following,
      required this.bio});
}
