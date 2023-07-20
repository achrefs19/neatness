import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/chat_messages.dart';
import 'package:flutter_projects/Components/new_message.dart';
import 'package:flutter_projects/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static String id = '/chat_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(onPressed: ()=>FirebaseAuth.instance.signOut(), icon: Icon(Icons.exit_to_app,color: primaryColor,))
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );
  }
}
