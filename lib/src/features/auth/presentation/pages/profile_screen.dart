import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        direction: Axis.vertical,
        children: [
          Center(
            child: Container(
              color: Colors.deepPurple,
              child: Column(
                children: [
                  Text('${context.read<AuthCubit>().getUser()!.displayName}'),
                  Text('${context.read<AuthCubit>().getUser()!.email}'),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().logOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
