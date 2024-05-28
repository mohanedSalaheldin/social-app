import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/chat/data/models/message_model.dart';
import 'package:social_app/src/features/chat/domain/repositories/chats_repositories.dart';

class SendMsgUseCase {
  final ChatRepository chatRepository;
  SendMsgUseCase({required this.chatRepository});
  void call(MessageModel messageModel, String entryId) {
    return chatRepository.sendMessage(messageModel, entryId);
  }
}
