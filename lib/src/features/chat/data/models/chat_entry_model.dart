class ChatEntryModel {
  String from;
  String lastMsg;
  DateTime lastTime;
  int msgNum;
  String to;
  String fromImageUrl;
  String toImageUrl;
  String fromName;
  String toName;
  String id;
  ChatEntryModel(
      {required this.from,
      required this.lastMsg,
      required this.lastTime,
      required this.msgNum,
      required this.fromImageUrl,
      required this.fromName,
      required this.toImageUrl,
      required this.toName,
      required this.to,
      required this.id});
  factory ChatEntryModel.fromJson(
      {required Map<String, dynamic> map, required id}) {
    return ChatEntryModel(
      id: id,
      from: map['from'],
      lastMsg: map['lastMsg'],
      lastTime: DateTime.parse(map['lastTime'].toDate().toString()),
      msgNum: map['msgNum'],
      to: map['to'],
      fromImageUrl: map['fromImageUrl'],
      toImageUrl: map['toImageUrl'],
      fromName: map['fromName'],
      toName: map['toName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'lastMsg': lastMsg,
      'lastTime': lastMsg,
      'msgNum': msgNum,
      'to': to,
      'fromImageUrl': fromImageUrl,
      'toImageUrl': toImageUrl,
      'fromName': fromName,
      'toName': toName
    };
  }
}
