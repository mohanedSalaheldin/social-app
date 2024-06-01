import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel(
      {required super.text,
      required super.writerName,
      required super.writerProfileImage,
      required super.id,
      required super.time,
      required super.postId,
      required super.replies});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        text: json['text'],
        writerName: json['writerName'],
        writerProfileImage: json['writerProfileImage'],
        id: json['id'],
        time: json['time'],
        postId: json['postId'],
        replies: json['replies']);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'writerName': writerName,
      'writerProfileImage': writerProfileImage,
      'id': id,
      'time': time,
      'postId': postId,
      'replies': replies
    };
  }

  factory CommentModel.forEntity(CommentEntity entity) {
    return CommentModel(
      text: entity.text,
      writerName: entity.writerName,
      writerProfileImage: entity.writerProfileImage,
      id: entity.id,
      time: entity.time,
      postId: entity.postId,
      replies: entity.replies,
      
    );
  }
}
