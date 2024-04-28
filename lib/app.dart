import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/config/themes/light_theme.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/src/features/auth/presentation/pages/profile_screen.dart';
import 'package:social_app/src/features/auth/presentation/pages/register_screen.dart';

import 'package:social_app/src/features/auth/presentation/widgets/presentation/cubit/home_cubit.dart';
import 'package:social_app/src/features/home/presentation/pages/home_screen.dart';
import 'src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'src/features/auth/presentation/pages/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social ',
      debugShowCheckedModeBanner: false,
      theme: getLightTheme(),

      home: MultiBlocProvider(
          providers: [BlocProvider(create: (_) => AuthCubit(AuthInitial()))],
          child: StreamBuilder(
            stream: AuthRemoteDataSourceImpl().auto(),
            builder: (context, snapshot) {
              // AuthRemoteDataSourceImpl().logout();
              if (snapshot.hasData) {
                return const Profile();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              return const LoginScreen();
            },
          )),
    );
  }
}

class holder extends StatefulWidget {
  const holder({super.key});

  @override
  State<holder> createState() => _holderState();
}

class _holderState extends State<holder> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
