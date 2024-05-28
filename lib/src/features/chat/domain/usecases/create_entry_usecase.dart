import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/chat/data/models/chat_entry_model.dart';
import 'package:social_app/src/features/chat/domain/repositories/chats_repositories.dart';

class CreateEntryUseCase {
  final ChatRepository chatRepository;
  CreateEntryUseCase({required this.chatRepository});
  void call(String fromUid, String toUid) {
    return chatRepository.createChatEntry(fromUid, toUid);
  }
}
