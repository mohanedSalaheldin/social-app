import 'package:social_app/src/features/chat/data/models/chat_entry_model.dart';
import 'package:social_app/src/features/chat/domain/repositories/chats_repositories.dart';

class GetChatEntriesUseCase {
  final ChatRepository chatRepository;
  GetChatEntriesUseCase({required this.chatRepository});
  Stream<List<ChatEntryModel>> call(String uid) {
    return chatRepository.getChatEntries(uid);
  }
}
