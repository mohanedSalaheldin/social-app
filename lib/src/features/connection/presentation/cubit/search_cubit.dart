import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/connection/domain/usecases/follow_unfollow_user_usecase.dart';
import 'package:social_app/src/features/connection/domain/usecases/get_all_users_usecase.dart';
import 'package:social_app/src/features/connection/domain/usecases/search_for_user_usecase.dart';

part 'search_state.dart';

class ConnectionCubit extends Cubit<ConnectionsState> {
  ConnectionCubit({
    required this.searchForUserUseCase,
    required this.getAllUsersUsecase,
    required this.followUnfollowUserUseCase,
  }) : super(ConnectionInitial());

  final SearchForUserUseCase searchForUserUseCase;
  final FollowUnfollowUserUseCase followUnfollowUserUseCase;
  final GetAllUsersUsecase getAllUsersUsecase;

  static ConnectionCubit get(context) => BlocProvider.of(context);

  List<UserInfoEntity> _searchResultUsers = [];

  List<UserInfoEntity> get searchResultUsers => _searchResultUsers;

  void searchForUser({required String keyword}) async {
    emit(ConnectionSearchForUserLoadingState());
    Either<Failure, List<UserInfoEntity>> result =
        await searchForUserUseCase.call(keyword: keyword);
    result.fold(
      (failure) {
        emit(ConnectionSearchForUserErrorState());
      },
      (searchResults) {
        print('${searchResults.length}');
        _searchResultUsers = [];
        _searchResultUsers = searchResults;
        emit(ConnectionSearchForUserSuccessState());
      },
    );
  }

  Stream<List<UserInfoEntity>> _allUsers = const Stream.empty();
  Stream<List<UserInfoEntity>> get allUsers => _allUsers;
  void getAllUsers() async {
    // emit(ConnectionGetAllUsersLoadingState());
    Either<Failure, Stream<List<UserInfoEntity>>> result =
        await getAllUsersUsecase.call();
    result.fold(
      (failure) {
        emit(ConnectionGetAllUsersErrorState());
      },
      (success) {
        print('${success.first}');
        _allUsers = success;

        emit(ConnectionGetAllUsersSuccessState());
      },
    );
  }

  void followUnfollowUser(
      {required String currentUserId, required String otherUserId}) async {
    // emit(ConnectionFollowUnfollowUsersLoadingState());

    Either<Failure, Unit> result = await followUnfollowUserUseCase.call(
        currentUserId: currentUserId, otherUserId: otherUserId);

    result.fold(
      (failure) {
        // emit(ConnectionFollowUnfollowUsersErrorState());
      },
      (success) {
        emit(ConnectionFollowUnfollowUsersSuccessState());
      },
    );
  }
}
