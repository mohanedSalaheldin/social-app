import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/src/features/chat/data/models/chat_entry_model.dart';
import 'package:social_app/src/features/chat/presentation/cubet/chats_cubit.dart';
import 'package:social_app/src/features/chat/presentation/widgets/chat_listtile.dart';

class AllChatsPage extends StatefulWidget {
  const AllChatsPage({super.key});

  @override
  State<AllChatsPage> createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: StreamBuilder<List<ChatEntryModel>>(
                stream: context.read<ChatsCubit>().getChatEntries(
                      context.read<AuthCubit>().getUser()!.uid,
                    ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ChatEntry(snapshot: snapshot, index: index);
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
