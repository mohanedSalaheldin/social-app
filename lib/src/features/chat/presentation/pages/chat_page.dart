import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/features/chat/data/models/message_model.dart';
import 'package:social_app/src/features/chat/presentation/cubet/chats_cubit.dart';

class ChatPage extends StatefulWidget {
  final String entryId;
  const ChatPage({super.key, required this.entryId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StreamBuilder(
            stream: context.read<ChatsCubit>().getMessages(widget.entryId),
            builder: (context, snapshot) {
              // context.read<ChatsCubit>().sendMsgUseCase.call(
              //     MessageModel(
              //         addtime: DateTime.now(),
              //         content: 'test of upload',
              //         type: 'text',
              //         uid: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1'),
              //     'SGv9v6AmBxwuXGduJMot');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text('No stream connected');
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.active:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  // snapshot.data= .data!.reversed;
                  return Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        alignment: snapshot.data![index].uid ==
                                'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: snapshot.data![index].uid ==
                                    'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1'
                                ? Colors.blueAccent
                                : Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10),
                              topRight: const Radius.circular(10),
                              bottomLeft: snapshot.data![index].uid ==
                                      'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1' // this will replaced by context.read<AuthCubit>().getUser()!.uid
                                  ? const Radius.circular(10)
                                  : const Radius.circular(0),
                              bottomRight: snapshot.data![index].uid ==
                                      'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1'
                                  ? const Radius.circular(0)
                                  : const Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data![index].content,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                snapshot.data![index].addtime
                                    .toLocal()
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                case ConnectionState.done:
                  return const Text('Stream has finished');
              }
            },
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: controller,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    context.read<ChatsCubit>().sendMsgUseCase.call(
                        MessageModel(
                          addtime: DateTime.now(),
                          content: controller.text,
                          type: 'text',
                          uid:
                              'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1', // this will replaced by context.read<AuthCubit>().getUser()!.uid
                        ),
                        widget.entryId);
                    controller.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
