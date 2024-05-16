class CommentEntity {
  final String comment;
  final String writerName;
  final String writerImageUrl;
  final DateTime time;
  final String postId;
  final String? replayTo;

  CommentEntity({required this.comment, required this.writerName, required this.writerImageUrl, required this.time, required this.postId, required this.replayTo});
}
