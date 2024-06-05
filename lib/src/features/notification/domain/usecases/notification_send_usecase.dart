import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/notification/domain/repositories/notification_repository.dart';

class NotificationSendUsecase {
  final NotificationRepository repository;

  NotificationSendUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(
      {required String receiverToken,
      required String title,
      required String body}) async {
    return await repository.pushNotification(
        receiverToken: receiverToken, title: title, body: body);
  }
}
