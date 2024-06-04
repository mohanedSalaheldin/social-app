import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/features/home/presentation/pages/home_screen.dart';
import 'package:social_app/src/features/notification/presentation/pages/notification_screen.dart';
import 'package:social_app/src/features/posts/presentation/pages/add_post_screen.dart';
import 'package:social_app/src/features/profile/presentation/pages/prfile_screen.dart';
import 'package:social_app/src/features/connection/presentation/pages/search_screen.dart';

part 'layout_cubit_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutCubitInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int _currentIndex = 3;
  get currentIndex => _currentIndex;

  UserInfoEntity _userInfoEntity = UserInfoEntity(
    userId: '',
    fcmToken: '',
    userName: '',
    email: '',
    profileImageURL: '',
    address: '',
    followers: [],
    following: [],
    bio: '',
  );
  String profileImageUrl = '';
  setUserInfoEntity(UserInfoEntity userInfoEntity) {
    _userInfoEntity = userInfoEntity;
    profileImageUrl = userInfoEntity.profileImageURL;
    emit(LayoutCurrentUserInfoChangeState());
  }

  UserInfoEntity get userInfo => _userInfoEntity;

  setCurrentScreen(int index) {
    _currentIndex = index;
    emit(LayoutNavBarIndexChangeState());
  }

  List<BottomNavigationBarItem> get navigationBarItems => [
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.home_14),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.discover_1),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.add_square),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.heart),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: '',
        ),
      ];

  final List<Widget> _screens = const [
    HomeScreen(),
    ConnectionScreen(),
    AddPostScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];
  get screens => _screens;
}
