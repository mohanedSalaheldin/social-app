import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/chat/data/datasoursec/chats_remote_datasource.dart';
import 'package:social_app/src/features/chat/data/models/chat_entry_model.dart';
import 'package:social_app/src/features/chat/data/models/message_model.dart';
import 'package:social_app/src/features/chat/domain/repositories/chats_repositories.dart';

class ChatsRepositoryImpl extends ChatRepository {
  ChatRemoteDatasource chatRemoteDatasource;
  NetworkInfo networkInfo;
  ChatsRepositoryImpl(
      {required this.chatRemoteDatasource, required this.networkInfo});
  @override
  void createChatEntry(String fromUid, String toUid) {
    return chatRemoteDatasource.createChatEntry(toUid, fromUid);
  }

  @override
  Stream<List<ChatEntryModel>> getChatEntries(String uid) {
    return chatRemoteDatasource.getChatEntries(uid);
  }

  @override
  Stream<List<MessageModel>> getMessages(String entryId) {
    return chatRemoteDatasource.getMessages(entryId);
  }

  @override
  void sendMessage(MessageModel messageModel, String entryId) {
    return chatRemoteDatasource.sendMessage(messageModel, entryId);
  }
}
