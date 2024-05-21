import 'package:social_app/src/core/entites/post_entity.dart';

class PostModel extends PostEntity {
  PostModel(
      {required super.imageUrl,
      required super.id,
      required super.userProfileImage,
      required super.text,
      required super.time,
      required super.likes,
      required super.comments,
      required super.writtenBy});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userProfileImage: '',
      writtenBy: 'json[]',
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
      'imageUrl': imageUrl,
      'id': id,
      'text': text,
      'time': time,
      'likes': likes.toString(),
      'comments': comments,
      'writtenBy': writtenBy,
      'userProfileImage': userProfileImage
    };
  }

  factory PostModel.forEntity(PostEntity entity) {
    return PostModel(
        userProfileImage: entity.userProfileImage,
        writtenBy: entity.writtenBy,
        imageUrl: entity.imageUrl,
        id: entity.id,
        text: entity.text,
        time: entity.time,
        likes: entity.likes,
        comments: entity.comments);
  }
}
