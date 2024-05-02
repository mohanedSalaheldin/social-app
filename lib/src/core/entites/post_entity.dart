class PostEntity {
  final String? imageUrl;
  final String id;
  final String text;
  final String time;
  final int likes;
  final int comments;

  PostEntity(
      {required this.imageUrl,
      required this.id,
      required this.text,
      required this.time,
      required this.likes,
      required this.comments});
}
