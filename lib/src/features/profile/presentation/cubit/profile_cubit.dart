import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_profile_info.dart';
import 'package:social_app/src/features/profile/domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileInfoUseCase getProfileInfoUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileCubit(
      {required this.getProfileInfoUseCase, required this.updateProfileUseCase})
      : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  void getProfileInfo({required String userId}) async {
    emit(ProfileLoadingState());
    Either<Failure, UserInfoEntity> result =
        await getProfileInfoUseCase.call(userId: userId);
    result.fold(
      (failure) {
        emit(ProfileErrorState(failure: failure));
      },
      (userInfoEntity) {
        emit(ProfileLoadedState(userInfoEntity: userInfoEntity));
      },
    );
  }

  void updateProfileInfo(
      {required String userId, required UserInfoEntity model}) async {
    emit(UpdateProfileLoadingState());
    Either<Failure, Unit> result =
        await updateProfileUseCase.call(userId: userId, model: model);
    result.fold(
      (failure) {
        emit(UpdateProfileErrorState(failure: failure));
      },
      (userInfoEntity) {
        emit(UpdateProfileLoadedState());
      },
    );
  }
}
