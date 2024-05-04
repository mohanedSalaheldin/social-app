import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/networks/network_info.dart';
import 'package:social_app/src/features/home/presentation/widgets/post_widget.dart';
import 'package:social_app/src/features/profile/data/datasources/profile_reomte_datasource.dart';
import 'package:social_app/src/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:social_app/src/features/profile/domain/usecases/delete_post_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/src/features/profile/domain/usecases/get_profile_info.dart';
import 'package:social_app/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (BuildContext context) => ProfileCubit(
        deletePostUseCase: DeletePostUseCase(
          repository: ProfileRepositoryImpl(
            networkInfo: NetworkInfoImpl(),
            profileRemoteDatasource: ProfileRemoteDatasourceImpl(),
          ),
        ),
        getPostsUseCase: GetPostsUseCase(
          repository: ProfileRepositoryImpl(
            networkInfo: NetworkInfoImpl(),
            profileRemoteDatasource: ProfileRemoteDatasourceImpl(),
          ),
        ),
        updateProfileUseCase: UpdateProfileUseCase(
          repository: ProfileRepositoryImpl(
            networkInfo: NetworkInfoImpl(),
            profileRemoteDatasource: ProfileRemoteDatasourceImpl(),
          ),
        ),
        getProfileInfoUseCase: GetProfileInfoUseCase(
          repository: ProfileRepositoryImpl(
            networkInfo: NetworkInfoImpl(),
            profileRemoteDatasource: ProfileRemoteDatasourceImpl(),
          ),
        ),
      ),
      // ..getProfileInfo(userId: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1'),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: const ProfileWidget(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // ProfileCubit.get(context)
                //     .getPosts(userId: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1');
                ProfileCubit.get(context).deletePost(
                    userId: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1',
                    postId: 'be5iAkz3RkgBc5xYCWwV');

                // ProfileCubit.get(context).updateProfileInfo(
                //   userId: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1',
                //   model: UserInfoEntity(
                //     userId: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1',
                //     userName: 'Ayman salah',
                //     email: 'whiteshadow2ppp2@gmail.com',
                //     profileImageURL: 'https://loremflickr.com/640/640',
                //     address: 'Cairo, Egypt',
                //     followers: 1,
                //     following: 1,
                //     bio: 'bio',
                //   ),
                // );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  '100',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('followers'),
              ],
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage('https://loremflickr.com/640/640'),
            ),
            Column(
              children: [
                Text(
                  '100',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('following'),
              ],
            ),
          ],
        ),
        const Gap(20),
        const Column(
          children: [
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Software Developer @ X'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on),
                Text('New York, USA'),
              ],
            ),
          ],
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  HexColor('#7737ff'),
                ),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
              child: const Text(
                'Follow',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
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
          itemBuilder: (context, index) => const PostWidget(),
          separatorBuilder: (context, index) => const Gap(20),
          itemCount: 5,
        ),
      ],
    );
  }
}
