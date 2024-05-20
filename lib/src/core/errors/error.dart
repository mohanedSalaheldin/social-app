import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  final String error = 'there is no connection';
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String error;

  ServerFailure({required this.error});

  @override
  List<Object?> get props => [];
}
