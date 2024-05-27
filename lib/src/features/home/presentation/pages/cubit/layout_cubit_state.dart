part of 'layout_cubit_cubit.dart';

sealed class LayoutState {
  const LayoutState();
}

final class LayoutCubitInitial extends LayoutState {}

final class LayoutNavBarIndexChangeState extends LayoutState {}
final class LayoutCurrentUserInfoChangeState extends LayoutState {}
