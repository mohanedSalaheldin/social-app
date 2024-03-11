import 'package:flutter/material.dart';
import 'package:social_app/src/config/themes/light_theme.dart';
import 'package:social_app/src/features/auth/presentation/pages/login_screen.dart';
import 'package:social_app/src/features/auth/presentation/pages/register_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social ',
      debugShowCheckedModeBanner: false,
      theme: getLightTheme(),
      home:  RegisterScreen(),
    );
  }
}
