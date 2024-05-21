import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/features/home/presentation/pages/home_screen.dart';
import 'package:social_app/src/features/posts/presentation/pages/add_post_screen.dart';
import 'package:social_app/src/features/profile/presentation/pages/prfile_screen.dart';
import 'package:social_app/src/features/search/presentation/pages/search_screen.dart';

part 'layout_cubit_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutCubitInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int _currentIndex = 1;
  get currentIndex => _currentIndex;

  UserInfoEntity _userInfoEntity = UserInfoEntity(
    userId: '',
    fcmToken: '',
    userName: '',
    email: '',
    profileImageURL: '',
    address: '',
    followers: 0,
    following: 0,
    bio: '',
  );
  setUserInfoEntity(UserInfoEntity userInfoEntity) {
    _userInfoEntity = userInfoEntity;
    emit(LayoutCurrentUserInfoChangeState());
  }

  UserInfoEntity get userInfo => _userInfoEntity;

  setCurrentScreen(int index) {
    _currentIndex = index;
    emit(LayoutNavBarIndexChangeState());
  }

  final List<BottomNavigationBarItem> _navigationBaritems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add_circle_outline),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border_outlined),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: '',
    ),
  ];

  get navigationBaritems => _navigationBaritems;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    AddPostScreen(),
    Text('3'),
    ProfileScreen()
  ];
  get screens => _screens;
}
