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
        userProfileImage: json['userProfileImage'],
        writtenBy: json['writtenBy'],
        imageUrl: json['imageUrl'],
        id: json['id'],
        text: json['text'],
        time: json['time'],
        likes: json['likes'],
        comments: json['comments']);
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'id': id,
      'text': text,
      'time': time,
      'likes': likes,
      'comments': comments,
    };
  }
}
