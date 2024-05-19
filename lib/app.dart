import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/config/routes/routes.dart';
import 'package:social_app/src/config/routes/routes_name.dart';
import 'package:social_app/src/config/themes/light_theme.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_cubit.dart';

import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_app/injection_container.dart' as di;
import 'package:social_app/src/features/search/presentation/cubit/search_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(
              AuthInitial(),
            ),
          ),
          BlocProvider(
            create: (_) => di.sl<ProfileCubit>()
              ..getProfileInfo(
                userId: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1',
              )
              ..getPosts(userId: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1'),
          ),
          BlocProvider(create: (_) => di.sl<SearchCubit>()),
          BlocProvider(create: (_) => di.sl<HomeCubit>()),
        ],
        child: MaterialApp(
          title: 'Social ',
          debugShowCheckedModeBanner: false,
          theme: getLightTheme(),
          onGenerateRoute: Routes.generateRoute,
          initialRoute: RoutesName.login,
          // home: const HomeScreen(),
        )

        //     StreamBuilder(
        //   stream: AuthRemoteDataSourceImpl().auto(),
        //   builder: (context, snapshot) {
        //     // AuthRemoteDataSourceImpl().logout();
        //     if (snapshot.connectionState == ConnectionState.active) {
        //       if (snapshot.hasData) {
        //         return const SearchScreen();
        //       }
        //       return const LoginScreen();
        //     }

        //     return Container(
        //       color: Colors.white,
        //       child: const Center(
        //           child: CircularProgressIndicator(
        //         color: Colors.purple,
        //       )),
        //     );
        //   },
        // ),

        );
  }
}
