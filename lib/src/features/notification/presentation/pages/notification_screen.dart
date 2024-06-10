import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        BlocProvider.of<NotificationCubit>(context)
            .getAllNotifications(userId: userId);
        Stream<List<String>> notifications =
            BlocProvider.of<NotificationCubit>(context).allNotifications;
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     ConnectionRemoteDataSourceImpl().followUnfollowUser(
          //         currentUserId: 'LsZXxg89FEWKlg4n7HaPuZ6wPnJ2',
          //         otherUserId: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1');
          //   },
          //   child: const Icon(Icons.send),
          // ),
          appBar: AppBar(
            title: const Text('Notification'),
          ),
          body: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: StreamBuilder<List<String>>(
                stream: notifications,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No notifications available'));
                  } else {
                    return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => NotificationCardWidget(
                        body: snapshot.data![index],
                      ),
                    );
                  }
                }),
          ),
        );
      },
    );
  }
}

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    required this.body,
  });
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Card(
        child: Center(
          child: ListTile(
            leading: const Icon(Iconsax.notification),
            title: Text(
              body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
