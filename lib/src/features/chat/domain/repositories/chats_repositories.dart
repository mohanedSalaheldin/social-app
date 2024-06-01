import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/chat/data/models/chat_entry_model.dart';
import 'package:social_app/src/features/chat/data/models/message_model.dart';

abstract class ChatRepository {
  Stream<List<ChatEntryModel>> getChatEntries(String uid);
  Stream<List<MessageModel>> getMessages(String entryId);
  void sendMessage(MessageModel messageModel, String entryId);
  void createChatEntry(String fromUid, String toUid);
}
