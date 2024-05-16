import 'package:social_app/src/features/home/domain/entities/comment_entity.dart';

class CommetModel extends CommentEntity {
  CommetModel({required super.comment, required super.writerName, required super.writerImageUrl, required super.time, required super.postId, required super.replayTo});

  factory CommetModel.fromJson(Map<String, dynamic> json) {
    return CommetModel(
      comment: json['comment'],
      writerName: json['writerName'],
      writerImageUrl: json['writerImageUrl'],
      time: DateTime.parse(json['time']),
      postId: json['postId'],
      replayTo: json['replayTo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'writerName': writerName,
      'writerImageUrl': writerImageUrl,
      'time': time.toString(),
      'postId': postId,
      'replayTo': replayTo,
    };
  }
}