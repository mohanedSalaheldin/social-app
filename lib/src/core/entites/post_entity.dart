class PostEntity {
  final String userProfileImage;
  final String? imageUrl;
  final String id;
  final String text;
  final String writtenBy;
  final String time;
  final List<String> likes;
  final int comments;

  PostEntity({
    required this.writtenBy,
    required this.imageUrl,
    required this.userProfileImage,
    required this.id,
    required this.text,
    required this.time,
    required this.likes,
    required this.comments,
  });
}
