class ProfileUserEntity {
  final String userName;
  final String profileImagePath;
  final String id;
  final String address;
  final int followers;
  final int following;

  ProfileUserEntity(
      {required this.userName,
      required this.profileImagePath,
      required this.id,
      required this.address,
      required this.followers,
      required this.following});
  // final int posts;
}
