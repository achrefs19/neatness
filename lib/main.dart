import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_projects/constants.dart';
import 'package:flutter_projects/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_projects/screens/chat.dart';
import 'package:flutter_projects/screens/create_event.dart';
import 'package:flutter_projects/screens/map_neatness.dart';
import 'package:flutter_projects/screens/profile_screen.dart';
import 'package:flutter_projects/screens/splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Neatness',
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: Scaffold(
            body: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  }
                  if (snapshot.hasData) {
                    return CreateEvent();
                  }
                  return const Inscription();
                })));
  }
}
