import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';

abstract class NotificationRepository {
  Future<Either<Failure, Unit>> pushNotification(
      {required String receiverToken,
      required String title,
      required String body});
  Future<Either<Failure, Stream<List<String>>>> getAllNotifications({required String userId});
}
