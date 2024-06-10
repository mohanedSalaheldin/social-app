part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {}

class NotificationError extends NotificationState {}

class NotificationGetAllError extends NotificationState {}

class NotificationGetAllSuccess extends NotificationState {}

class NotificationGetAllLoading extends NotificationState {}
