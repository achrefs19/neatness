import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/rounded_button.dart';
import 'package:flutter_projects/Components/rounded_text_field.dart';
import 'package:flutter_projects/models/userEntity.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        title: Title(
        color: Colors.lightGreenAccent, child: const Text('Neatness')),
          actions: [IconButton(onPressed: ()=>FirebaseAuth.instance.signOut(), icon: Icon(Icons.exit_to_app,color: Colors.red,))],
    ),
    body: Container(
    margin: EdgeInsets.all(30),
    child: Text("Hello"))));
  }
}
