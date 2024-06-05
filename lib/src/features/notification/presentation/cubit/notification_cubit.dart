import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/features/notification/domain/usecases/notification_send_usecase.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationSendUsecase notificationSendUsecase;
  NotificationCubit({required this.notificationSendUsecase})
      : super(NotificationInitial());


  static NotificationCubit get(context) =>
      BlocProvider.of<NotificationCubit>(context);

  void sendNewMassageNotification({
    required String receiverToken,
    required String senderName,
  }) async {
    _sendNotification(
        receiverToken: receiverToken, body: 'New message from $senderName');
  }

  void sendLikeNotification({
    required String receiverToken,
    required String senderName,
  }) async {
    _sendNotification(
        receiverToken: receiverToken, body: '$senderName liked your post');
  }

  void sendCommentNotification({
    required String receiverToken,
    required String senderName,
  }) async {
    _sendNotification(
        receiverToken: receiverToken,
        body: '$senderName commented on your post');
  }

  void sendNewFollowerNotification({
    required String receiverToken,
    required String senderName,
  }) async {
    _sendNotification(
        receiverToken: receiverToken, body: '$senderName has followed you');
  }

  void _sendNotification({
    required String receiverToken,
    // required String senderName,
    required String body,
  }) async {
    emit(NotificationLoading());
    final result = await notificationSendUsecase.call(
        receiverToken: receiverToken, title: appName, body: body);
    result.fold((l) {
      emit(NotificationError());
    }, (r) {
      emit(NotificationSuccess());
    });
  }
}
