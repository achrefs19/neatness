import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/rounded_button.dart';
import 'package:flutter_projects/Components/rounded_text_field.dart';
import 'package:flutter_projects/models/userEntity.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Title(
                  color: Colors.lightGreenAccent, child: const Text('Neatness')),
            ),
            body: const Center(
                child: Text("Loading..."))));
  }
}