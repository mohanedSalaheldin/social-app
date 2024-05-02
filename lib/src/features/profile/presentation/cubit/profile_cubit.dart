import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_profile_info.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileInfoUseCase getProfileInfoUseCase;

  ProfileCubit({required this.getProfileInfoUseCase}) : super(ProfileInitial());
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
}
