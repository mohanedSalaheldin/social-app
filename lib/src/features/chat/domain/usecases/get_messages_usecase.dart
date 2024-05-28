import 'package:social_app/src/features/chat/data/models/message_model.dart';
import 'package:social_app/src/features/chat/domain/repositories/chats_repositories.dart';

class GetMessagesUseCase {
  final ChatRepository chatRepository;
  GetMessagesUseCase({required this.chatRepository});
  Stream<List<MessageModel>> call(String entryId) {
    return chatRepository.getMessages(entryId);
  }
}
