import 'package:flutter/material.dart';
import 'package:social_app/src/features/notification/data/datasources/notification_datasource.dart';
import 'package:social_app/src/features/notification/data/datasources/services.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // NotificationDataSourceImpl().sendPushMessage(
          //     receiverToken:
          //         'ca7U_apsRM2W964pi3KpsA:APA91bGhMoyK23HKrsKEfwuND1uWG2NnLHQN91xlatA3i1R2UyZ4Pql6UgciNGsc-mYWC9ySEMP5OU7GhIlsLwmHqJ-NWjZZq4u_Lcs5DlTcQ55JVcSxkRhoviDVaWWNVrpywiSD2cCo',
          //     title: 'Notfication using RustAPI',
          //     body: "some body");

          await NotificationService().sendPushMessage(
              token:
                  'ca7U_apsRM2W964pi3KpsA:APA91bGhMoyK23HKrsKEfwuND1uWG2NnLHQN91xlatA3i1R2UyZ4Pql6UgciNGsc-mYWC9ySEMP5OU7GhIlsLwmHqJ-NWjZZq4u_Lcs5DlTcQ55JVcSxkRhoviDVaWWNVrpywiSD2cCo',
              title: 'Notfication using RustAPI',
              body: "some body");
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
