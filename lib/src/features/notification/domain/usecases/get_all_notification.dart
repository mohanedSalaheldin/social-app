import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/notification/domain/repositories/notification_repository.dart';

class GetAllNotificationsUsecase {
  final NotificationRepository repository;

  GetAllNotificationsUsecase({required this.repository});

 Future<Either<Failure, Stream<List<String>>>>  call(
      {required String userId}) async {
    return await repository.getAllNotifications(userId: userId);
  }
}
