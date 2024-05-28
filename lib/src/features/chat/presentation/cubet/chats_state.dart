import 'package:equatable/equatable.dart';

sealed class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class InitalState extends ChatsState {}
