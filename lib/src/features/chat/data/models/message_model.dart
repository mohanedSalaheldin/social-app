class MessageModel {
  DateTime addtime;
  String content;
  String type;
  String uid;
  MessageModel({
    required this.addtime,
    required this.content,
    required this.type,
    required this.uid,
  });
  factory MessageModel.fromJson({required Map<String, dynamic> map}) {
    return MessageModel(
        addtime: DateTime.parse(map['addtime'].toDate().toString()),
        content: map['content'],
        type: map['type'],
        uid: map['uid']);
  }
  Map<String, dynamic> toJson() {
    return {
      'addtime': addtime,
      'content': content,
      'type': type,
      'uid': uid,
    };
  }
}
