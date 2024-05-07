import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/app.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();

  await di.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
