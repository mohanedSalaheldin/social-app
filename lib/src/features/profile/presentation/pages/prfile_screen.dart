import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/config/routes/navigate_methods.dart';
import 'package:social_app/src/config/routes/routes_name.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_app/src/features/profile/presentation/pages/profile_edit_screen.dart';
import 'package:social_app/src/features/profile/presentation/widgets/profile_body_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.userID,
  });
  final String? userID;

  @override
  Widget build(BuildContext context) {
    UserInfoEntity userInfoEntity = context.read<ProfileCubit>().userInfo;
   

    // // context.read<ProfileCubit>().getProfileInfo(userId: uId);
    // // context.read<ProfileCubit>().getPosts(userId: uId);
    // // user = context.read<ProfileCubit>().userInfo;
    return BlocBuilder<ProfileCubit, ProfileState>(
     
      builder: (context, state) {
        // if (state is ProfileDeletePostLoadingState ||
        //     state is ProfileGetPostsLoadingState ||
        //     state is ProfileUpdateInfoLoadingState ||
        //     state is ProfileInfoLoadingState) {
        //   return Scaffold(
        //     body: Center(
        //       child: CircularProgressIndicator(
        //         color: mainColor,
        //       ),
        //     ),
        //   );
        // }
        String currentUserID = FirebaseAuth.instance.currentUser?.uid ?? '';
        bool isProfileMine = _checkIfProfileIsMine(
            profileId: userInfoEntity.userId, currentUserID: currentUserID);
        return Scaffold(
          appBar: _buildAppBar(context, isProfileMine),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacementNamed(context, RoutesName.login);
              });
            },
            // backgroundColor: mainColor,
            child: const Icon(Iconsax.logout),
          ),
          body: ProfileWidget(
            userID: userInfoEntity.userId,
            isProfileMine: isProfileMine,
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isProfileMine) {
    return AppBar(
      actions: [
        isProfileMine
            ? PopupMenuButton<int>(
                onSelected: (value) {
                  if (value == 1) {
                    navigateToScreen(context, const ProfileInfoEditScreen());
                  } else if (value == 2) {}
                },
                icon: const Icon(Icons.menu),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Iconsax.edit),
                        Gap(10),
                        Text("Edit Profile")
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(Iconsax.logout),
                         Gap(10),
                        Text("Logout")
                      ],
                    ),
                  ),
                ],
                color: HexColor('#1f2128'),
                elevation: 2,
              )
            : const SizedBox(),
      ],
    );
  }

  bool _checkIfProfileIsMine({
    required String profileId,
    required String currentUserID,
  }) {
    return profileId == currentUserID;
  }
}
