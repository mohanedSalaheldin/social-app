import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/config/routes/navigate_methods.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/features/posts/presentation/pages/post_details_screen.dart';
import 'package:social_app/src/features/posts/presentation/widgets/post_widget.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileWidget extends StatefulWidget {
  final String userID;
  final bool isProfileMine;

  const ProfileWidget(
      {super.key, required this.isProfileMine, required this.userID});

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadUserInfoAndPosts(userId: widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    // UserInfoEntity user = widget.user!;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInfoLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        } else if (state is ProfileInfoErrorState) {
          return const Center(child: Text('Error loading profile'));
        } else if (state is ProfileInfoSucessState) {
          ProfileCubit profileCubit = ProfileCubit.get(context);

          // final user = widget.user;
          final postsStream = profileCubit.posts;
          profileCubit.getProfileDetails(userId: widget.userID);
          Stream<UserInfoEntity> userStream = profileCubit.profileDetails;
          return StreamBuilder<UserInfoEntity>(
            stream: userStream,
            builder: (context, snapshot) {
              
             UserInfoEntity user = snapshot.data!;
              return ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(user.followers.length.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Text('followers'),
                        ],
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.black,
                        backgroundImage:
                            NetworkImage(user.profileImageURL.toString()),
                      ),
                      Column(children: [
                        Text(
                          user.following.length.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('following'),
                      ])
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
                          const Icon(
                            Iconsax.location_tick,
                            color: Colors.white,
                          ),
                          Text(user.address.toString()),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  widget.isProfileMine
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyCustomizedElevatedButton(
                              text: 'Follow',
                              onPressed: () {},
                            ),
                            const Gap(10),
                            MyCustomizedElevatedButton(
                              text: 'Message',
                              isFilled: false,
                              onPressed: () {},
                            ),
                          ],
                        )
                      : const SizedBox(),
                  const Gap(20),
                  StreamBuilder<List<PostEntity>>(
                    stream: postsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red));
                      }
              
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child:
                              CircularProgressIndicator(color: Colors.cyanAccent),
                        );
                      }
              
                      if (snapshot.hasData) {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PostWidget(
                              userEntity: user,
                              post: snapshot.data![index],
                              onDeletePost: () {
                                ProfileCubit.get(context).deletePost(
                                  userId: user.userId.toString(),
                                  postId: snapshot.data![index].id.toString(),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const Gap(20),
                          itemCount: snapshot.data!.length,
                        );
                      }
              
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              );
            }
          );
        }

        return const Center(child: Text('Unexpected state'));
      },
    );
  }
}
