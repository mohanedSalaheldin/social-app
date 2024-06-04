import 'package:flutter/material.dart';
import 'package:social_app/src/features/connection/data/datasources/search_remote_datasource.dart';
import 'package:social_app/src/features/notification/data/datasources/notification_datasource.dart';
import 'package:social_app/src/features/notification/data/datasources/services.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ConnectionRemoteDataSourceImpl().followUnfollowUser(
              currentUserId: 'LsZXxg89FEWKlg4n7HaPuZ6wPnJ2',
              otherUserId: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1');
        },
        child: const Icon(Icons.send),
      ),
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: const Center(
        child: Text('Notification'),
      ),
    );
  }
}
