import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_state.dart';
import 'package:social_app/src/features/home/presentation/pages/cubit/layout_cubit_cubit.dart';
import 'package:social_app/src/features/posts/presentation/widgets/post_widget.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // String? userId = FirebaseAuth.instance.currentUser!.uid;
    // context.read<HomeCubit>().getPosts();
    // context.read<HomeCubit>()
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ProfileCubit profileCubit = context.read<ProfileCubit>();

        // profileCubit.getProfileInfo(
        //     userId: FirebaseAuth.instance.currentUser!.uid);
        return BlocProvider(
          create: (context) =>
              LayoutCubit()..setUserInfoEntity(profileCubit.userInfo),
          child: BlocConsumer<LayoutCubit, LayoutState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = LayoutCubit.get(context);
              return Scaffold(
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     print('--------------------------------');

                //     print(profileCubit.userInfo.profileImageURL);
                //     print('--------------------------------');
                //   },
                //   child: const Icon(Icons.add),
                // ),
                body: cubit.screens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (value) {
                    cubit.setCurrentScreen(value);
                  },
                  currentIndex: cubit.currentIndex,
                  // selectedItemColor: HexColor('#7737ff'),
                  type: BottomNavigationBarType.fixed,
                  elevation: 0.0,
                  // iconSize: 30.0,
                  items: cubit.navigationBarItems,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileCubit.get(context)
        .getProfileInfo(userId: FirebaseAuth.instance.currentUser!.uid);
    UserInfoEntity user = ProfileCubit.get(context).userInfo;
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Home'),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.email_outlined),
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              
                stream: BlocProvider.of<HomeCubit>(context).getPosts(),
                builder: (context, snapshot) {
                  // print(snapshot.error);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: const [
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(child: Text('No posts yet'));
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => PostWidget(
                          userEntity: user,
                          post: snapshot.data![index],
                          onDeletePost: () {}),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ),
        ],
      ),
    );
  }
}
