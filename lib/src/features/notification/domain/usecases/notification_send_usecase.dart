import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/notification/domain/repositories/notification_repository.dart';

class NotificationSendUsecase {
  final NotificationRepository notificationRepository;

  NotificationSendUsecase({required this.notificationRepository});

  Future<Either<Failure, Unit>> call(
      {required String receiverToken,
      required String title,
      required String body}) async {
    return await notificationRepository.pushNotification(
        receiverToken: receiverToken, title: title, body: body);
  }
}
