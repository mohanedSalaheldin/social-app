import 'package:social_app/src/core/entites/post_entity.dart';

class PostModel extends PostEntity {
  PostModel(
      {required super.imageUrl,
      required super.writerId,
      required super.id,
      required super.userProfileImage,
      required super.text,
      required super.writerFCMToken,
      required super.time,
      required super.likes,
      required super.comments,
      required super.writtenBy});

  factory PostModel.fromJson(Map<String, dynamic> json,) {
    return PostModel(
      writerFCMToken: json['writerFCMToken'],
      writerId: json['writerId'],
      userProfileImage: json['userProfileImage'],
      writtenBy: json['writtenBy'],
      imageUrl: json['imageUrl'],
      id: json['id'],
      text: json['text'],
      time: json['time'],
      likes: List<String>.from(json['likes']),
      comments: json['comments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'writerId': writerId,
      'writerFCMToken': writerFCMToken,
      'imageUrl': imageUrl,
      'id': id,
      'text': text,
      'time': time,
      'likes': likes,
      'comments': comments,
      'writtenBy': writtenBy,
      'userProfileImage': userProfileImage

    };
  }

  factory PostModel.forEntity(PostEntity entity) {
    return PostModel(
        writerId: entity.writerId,
        userProfileImage: entity.userProfileImage,
        writtenBy: entity.writtenBy,
        imageUrl: entity.imageUrl,
        id: entity.id,
        text: entity.text,
        writerFCMToken: entity.writerFCMToken,
        time: entity.time,
        likes: entity.likes,
        comments: entity.comments);
  }
}
