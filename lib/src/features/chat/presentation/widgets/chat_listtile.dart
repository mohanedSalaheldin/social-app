import 'package:flutter/material.dart';
import 'package:social_app/src/features/chat/data/models/chat_entry_model.dart';
import 'package:social_app/src/features/chat/presentation/pages/chat_page.dart';

class ChatEntry extends StatefulWidget {
  final AsyncSnapshot<List<ChatEntryModel>> snapshot;
  final int index;
  const ChatEntry({super.key, required this.snapshot, required this.index});

  @override
  State<ChatEntry> createState() => _ChatEntryState();
}

class _ChatEntryState extends State<ChatEntry> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage:
            NetworkImage(widget.snapshot.data![widget.index].toImageUrl),
        radius: 25,
        child: const Text('JS'),
      ),
      title: Text(widget.snapshot.data![widget.index].toName),
      subtitle: Text(widget.snapshot.data![widget.index].lastMsg),
      trailing: Text(
        widget.snapshot.data![widget.index].lastTime.toString(),
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatPage(
                entryId: widget.snapshot.data![widget.index].id,
              );
            },
          ),
        );
      },
    );
  }
}
