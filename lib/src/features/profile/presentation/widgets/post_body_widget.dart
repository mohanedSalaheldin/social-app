import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/features/posts/presentation/widgets/post_widget.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late UserInfoEntity user;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileDeletePostLoadingState ||
            state is ProfileGetPostsLoadingState ||
            state is ProfileUpdateInfoLoadingState ||
            state is ProfileInfoLoadingState) {
          return Center(
              child: Container(
            color: Colors.red,
            child: const CircularProgressIndicator(color: Colors.red),
          ));
        } else if (state is ProfileDeletePostErrorState ||
            state is ProfileGetPostsErrorState ||
            state is ProfileUpdateInfoErrorState ||
            state is ProfileInfoErrorState) {
          return const Center(child: Text('Error'));
        } else {
          user = ProfileCubit.get(context).userInfo;
          ProfileCubit.get(context).getPosts(userId: user.userId);
          Stream<List<PostEntity>> posts = ProfileCubit.get(context).posts;

          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(user.followers.toString(),
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
                      user.following.toString(),
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
              Row(
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
              ),
              const Gap(20),
              StreamBuilder(
                stream: posts,
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting ||
                  //     snapshot.data!.isEmpty ||
                  //     snapshot.hasError) {
                  //   return const SafeArea(
                  //     child: Center(
                  //       child: CircularProgressIndicator(
                  //         color: Colors.transparent,
                  //       ),
                  //     ),
                  //   );
                  // } else
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
              )
            ],
          );
        }
      },
    );
  }
}
