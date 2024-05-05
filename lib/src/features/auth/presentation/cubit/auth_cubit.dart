import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:social_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:social_app/src/features/auth/domain/usecases/getUser_usecase.dart';
import 'package:social_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:social_app/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:social_app/src/features/auth/domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  File? profileImage;
  Stream<User?> auto = const Stream.empty();
  AuthCubit(super.initialState) {
    auto = AuthRemoteDataSourceImpl().auto();
  }

  AuthCubit get(context) => BlocProvider.of(context);

  User? getUser() {
    return GetUserUseCase(
            repository: AuthRepositoryImpl(
                authRemoteDataSource: AuthRemoteDataSourceImpl(),
                networkInfo: NetworkInfoImpl()))
        .call();
  }

  Future<void> login({
    required email,
    required password,
  }) async {
    emit(AuthLoginLoading());
    var response = await LoginUseCase(
      repository: AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(),
        networkInfo: NetworkInfoImpl(),
      ),
    ).call(email: email, password: password);
    response.fold((Failure failure) {
      emit(AuthLoginError(error: failure));
    }, (Unit unit) {
      emit(AuthLoginSuccess());
    });
  }

  void logOut() {
    LogoutUseCase(
            repository: AuthRepositoryImpl(
                authRemoteDataSource: AuthRemoteDataSourceImpl(),
                networkInfo: NetworkInfoImpl()))
        .call();
  }

  Future<void> register(
      {required email,
      required password,
      required userName,
      required imagePath}) async {
    emit(AuthRegisterLoading());
    var response = await RegisterUseCase(
      repository: AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(),
        networkInfo: NetworkInfoImpl(),
      ),
    ).call(
        email: email,
        password: password,
        userName: userName,
        prfileImagePath: profileImage);
    response.fold((Failure failure) {
      emit(AuthRegisterError(error: failure));
    }, (Unit unit) {
      emit(AuthRegisterSuccess());
    });
  }
}
