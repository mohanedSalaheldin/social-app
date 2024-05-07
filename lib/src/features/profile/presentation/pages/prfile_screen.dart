import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_app/src/config/routes/navigate_methods.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/features/home/presentation/widgets/post_widget.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_app/src/features/profile/presentation/pages/profile_edit_screen.dart';
import 'package:social_app/injection_container.dart' as di;

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
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  navigateToScreen(context, const ProfileInfoEditScreen());
                  // FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.edit,
                ),
              )
            ],
          ),
          body: const ProfileWidget(),
        );
      },
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late UserInfoEntity user;
    late List<PostEntity> posts;

    return BlocBuilder<ProfileCubit, ProfileState>(
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
          ));
        } else if (state is ProfileDeletePostErrorState ||
            state is ProfileGetPostsErrorState ||
            state is ProfileUpdateInfoErrorState ||
            state is ProfileInfoErrorState) {
          return const Center(child: Text('Error'));
        } else {
          user = ProfileCubit.get(context).userInfo;
          posts = ProfileCubit.get(context).posts;
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        user.followers.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('followers'),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    backgroundImage:
                        NetworkImage(user.profileImageURL.toString()),
                  ),
                  Column(
                    children: [
                      Text(
                        user.following.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('following'),
                    ],
                  ),
                ],
              ),
              const Gap(20),
              Column(
                children: [
                  Text(
                    user.userName.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(user.bio.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on),
                      Text(user.address.toString()),
                    ],
                  ),
                ],
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCustomizedElevatedButton(
                    text: 'Follow',
                    onPressed: () {},
                  ),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.white,
                      ),
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Message',
                    ),
                  ),
                ],
              ),
              const Gap(20),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return PostWidget(
                    post: posts[index],
                    onDeletePost: () {
                      ProfileCubit.get(context).deletePost(
                        userId: user.userId.toString(),
                        postId: posts[index].id.toString(),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Gap(20),
                itemCount: posts.length,
              ),
            ],
          );
        }
      },
    );
  }
}
