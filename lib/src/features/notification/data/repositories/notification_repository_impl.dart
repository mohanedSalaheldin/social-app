import 'package:dartz/dartz.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/notification/data/datasources/notification_datasource.dart';
import 'package:social_app/src/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource notificationDataSource;
  final NetworkInfo networkInfo;

  NotificationRepositoryImpl(
      {required this.notificationDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> pushNotification(
      {required String receiverToken,
      required String title,
      required String body}) async {
    if (await networkInfo.isConnected) {
      try {
        notificationDataSource.sendPushMessage(
            receiverToken: receiverToken, title: title, body: body);

        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<List<String>>>> getAllNotifications(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        Stream<List<String>> stream =
            await notificationDataSource.getAllNotifications(userId: userId);

        return Right(stream);
      } catch (e) {
        return Left(ServerFailure(error: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
