part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchForUserLoadingState extends SearchState {}

class SearchForUserSuccessState extends SearchState {}

class SearchForUserErrorState extends SearchState {}
