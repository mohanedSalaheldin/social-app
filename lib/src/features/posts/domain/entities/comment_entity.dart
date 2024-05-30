class CommentEntity {
  final String id;
  final String postId;
  final String writerName;
  final String writerProfileImage;
  final String text;
  final String time;
  List<CommentEntity>? replies;

  CommentEntity({
    this.replies,
    required this.postId,
    required this.id,
    required this.writerName,
    required this.writerProfileImage,
    required this.text,
    required this.time,
  });
}
