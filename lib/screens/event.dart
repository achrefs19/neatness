import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Title(
                  color: Colors.lightGreenAccent, child: const Text('Neatness')),
            ),
            body: Container(
                margin: EdgeInsets.all(30),
                child: Text("Hello"))));
  }
}