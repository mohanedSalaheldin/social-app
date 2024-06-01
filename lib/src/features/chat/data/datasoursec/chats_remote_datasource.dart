import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/chat/data/models/chat_entry_model.dart';
import 'package:social_app/src/features/chat/data/models/message_model.dart';

abstract class ChatRemoteDatasource {
  Stream<List<ChatEntryModel>> getChatEntries(String uid);
  Stream<List<MessageModel>> getMessages(String entryId);
  void sendMessage(MessageModel messageModel, String chatEntryid);
  void createChatEntry(String toUid, String fromUid);
}

class ChatRemoteDatasourceImpl extends ChatRemoteDatasource {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  // final FirebaseStorage _bucket = FirebaseStorage.instance;
  @override
  void createChatEntry(String toUid, String fromUid) {
    _store.collection('messages').add(ChatEntryModel(
          id: 'gg',
          from: fromUid,
          lastMsg: '',
          lastTime: DateTime.now(),
          msgNum: 0,
          to: toUid,
          fromImageUrl: '',
          fromName: '',
          toImageUrl: '',
          toName: '',
        ).toJson());
  }

  @override
  Stream<List<ChatEntryModel>> getChatEntries(String uid) {
    return _store
        .collection('messages')
        // .where('from', isEqualTo: '')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              ChatEntryModel.fromJson(map: snapshot.data()!, id: snapshot.id),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  @override
  Stream<List<MessageModel>> getMessages(String entryId) {
    return _store
        .collection('messages')
        .doc(entryId)
        .collection('msg_list')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MessageModel.fromJson(map: snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .orderBy('addtime', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  @override
  void sendMessage(MessageModel messageModel, String chatEntryid) {
    _store
        .collection('messages')
        .doc(chatEntryid)
        .collection('msg_list')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MessageModel.fromJson(map: snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .add(messageModel);
  }
}
