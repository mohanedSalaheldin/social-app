import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/features/chat/data/models/chat_entry_model.dart';
import 'package:social_app/src/features/chat/data/models/message_model.dart';
import 'package:social_app/src/features/chat/domain/usecases/get_entries_usecase.dart';
import 'package:social_app/src/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:social_app/src/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:social_app/src/features/chat/presentation/cubet/chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  GetChatEntriesUseCase getChatEntriesUseCase;
  GetMessagesUseCase getMessagesUseCase;
  SendMsgUseCase sendMsgUseCase;
  ChatsCubit(
      {required this.getChatEntriesUseCase,
      required this.getMessagesUseCase,
      required this.sendMsgUseCase})
      : super(InitalState());
  ChatsCubit get(context) => BlocProvider.of(context);

  Stream<List<ChatEntryModel>> getChatEntries(String uid) {
    return getChatEntriesUseCase.call(uid);
  }

  Stream<List<MessageModel>> getMessages(String cid) {
    return getMessagesUseCase.call(cid);
  }
}
