import 'package:social_app/src/core/entites/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.id,
    required super.comments,
    required super.imageUrl,
    required super.likes,
    required super.text,
    required super.time,
    required super.userProfileImage,
    required super.writtenBy,
  });

  factory PostModel.fromJson({required Map<String, dynamic> map}) {
    return PostModel(
        id: map['id'],
        comments: map['comments'],
        imageUrl: map['imageUrl'],
        likes: map['likes'],
        text: map['text'],
        time: map['time'],
        userProfileImage: map['userProfileImage'],
        writtenBy: map['writtenBy']);
  }
  toJson({required PostModel model}) {
    Map<String, dynamic> map = {};
    return map;
  }
}
