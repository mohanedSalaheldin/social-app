import 'package:flutter/material.dart';
import 'package:social_app/src/config/routes/routes_name.dart';
import 'package:social_app/src/features/auth/presentation/pages/login_screen.dart';
import 'package:social_app/src/features/auth/presentation/pages/register_screen.dart';
import 'package:social_app/src/features/home/presentation/pages/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.layout:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LayoutScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterScreen());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text('No route defined')),
            );
          },
        );
    }
  }
}
