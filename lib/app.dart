import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/config/routes/routes.dart';
import 'package:social_app/src/config/routes/routes_name.dart';
import 'package:social_app/src/config/themes/light_theme.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/src/features/chat/presentation/cubet/chats_cubit.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/src/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_app/injection_container.dart' as di;
import 'package:social_app/src/features/search/presentation/cubit/search_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // String? userId = FirebaseAuth.instance.currentUser!.uid;
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(AuthInitial())),
          BlocProvider(create: (_) => di.sl<ProfileCubit>()),
          BlocProvider(create: (_) => di.sl<SearchCubit>()),
          BlocProvider(create: (_) => di.sl<PostsCubit>()),
          BlocProvider(create: (_) => di.sl<HomeCubit>()),
          BlocProvider(create: (_) => di.sl<ChatsCubit>()),
        ],
        child: MaterialApp(
          title: 'Social ',
          debugShowCheckedModeBanner: false,
          theme: getLightTheme(),
          onGenerateRoute: Routes.generateRoute,
          initialRoute: _chooseInitialRoute(),
          // home: const HomeScreen(),
        ));
  }

  String _chooseInitialRoute() {
    print(FirebaseAuth.instance.currentUser!.uid);
    return FirebaseAuth.instance.currentUser == null
        ? RoutesName.login
        : RoutesName.layout;
  }
}
