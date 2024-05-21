import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/errors/error.dart';
import 'package:social_app/src/features/search/domain/usecases/search_for_user_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchForUserUseCase}) : super(SearchInitial());

  final SearchForUserUseCase searchForUserUseCase;

  static SearchCubit get(context) => BlocProvider.of(context);

  List<UserInfoEntity> _searchResultUsers = [];

  List<UserInfoEntity> get searchResultUsers => _searchResultUsers;

  void searchForUser({required String keyword}) async {
    emit(SearchForUserLoadingState());
    Either<Failure, List<UserInfoEntity>> result =
        await searchForUserUseCase.call(keyword: keyword);
    result.fold(
      (failure) {
        emit(SearchForUserErrorState());
      },
      (searchResults) {
        print('${searchResults.length}');
        _searchResultUsers = [];
        _searchResultUsers = searchResults;
        emit(SearchForUserSuccessState());
      },
    );
  }
}
