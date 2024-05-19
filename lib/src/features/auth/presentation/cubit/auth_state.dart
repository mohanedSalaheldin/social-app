part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {}

final class AuthLoginError extends AuthState {
  final String error;
  const AuthLoginError({required this.error});
}

final class AuthRegisterLoading extends AuthState {}

final class AuthRegisterSuccess extends AuthState {}

final class AuthRegisterError extends AuthState {
  final Failure error;
  const AuthRegisterError({required this.error});
}

final class AuthSetupProfileLoading extends AuthState {}

final class AuthSetupProfileSuccess extends AuthState {}

final class AuthSetupProfileError extends AuthState {}
