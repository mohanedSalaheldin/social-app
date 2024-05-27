import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/config/routes/navigate_methods.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/features/posts/presentation/widgets/post_widget.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_app/src/features/profile/presentation/pages/profile_edit_screen.dart';
import 'package:social_app/injection_container.dart' as di;
import 'package:social_app/src/features/profile/presentation/widgets/post_body_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProfileDeletePostLoadingState ||
            state is ProfileGetPostsLoadingState ||
            state is ProfileUpdateInfoLoadingState ||
            state is ProfileInfoLoadingState) {
          return Center(
            child: Container(
              color: Colors.amberAccent,
              child: const CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          );
        }
        return const Scaffold(
          // appBar: _buildAppBar(context),
          body: ProfileWidget(),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        PopupMenuButton<int>(
          onSelected: (value) {
            if (value == 1) {
              navigateToScreen(context, const ProfileInfoEditScreen());
            } else if (value == 2) {}
          },
          icon: const Icon(Icons.menu),
          itemBuilder: (context) => [
            // popupmenu item 1
            const PopupMenuItem(
              value: 1,
              // row has two child icon and text.
              child: Row(
                children: [
                  Icon(Iconsax.edit),
                  SizedBox(
                    // sized box with width 10
                    width: 10,
                  ),
                  Text("Edit Profile")
                ],
              ),
            ),
            // popupmenu item 2
            const PopupMenuItem(
              value: 2,
              // row has two child icon and text
              child: Row(
                children: [
                  Icon(Iconsax.logout),
                  SizedBox(
                    // sized box with width 10
                    width: 10,
                  ),
                  Text("Logout")
                ],
              ),
            ),
          ],
          // offset: const Offset(, 30),
          color: HexColor('#1f2128'),
          elevation: 2,
        ),
      ],
    );
  }
}
