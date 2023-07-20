import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  //set up a listener which autmatically listens to the chat collection to automatically notify any changes
  //and then it will trigger the builder function to update the UI
  //snapshot object give us access to the data that was loaded from the backend
  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: false).snapshots(),
        builder: (context, chatSnapshots) {
          //test if receive some data
          if (chatSnapshots.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //check if we don't have data
          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty){
            return const Center(
              child: Text('No messages found.'),
            );
          }
          //check if we have an error
          if (chatSnapshots.hasError){
            return const Center(
              child: Text('No messages found.'),
            );
          }
          //if we know that we have data
          //get our loaded messages
          final loadedMessages = chatSnapshots.data!.docs;
          return ListView.builder(
              padding: const EdgeInsets.only(bottom: 40, left: 13,right: 13),
              reverse: true,
              itemCount: loadedMessages.length,
              itemBuilder: (context, index) {
                final chatMessage = loadedMessages[index].data();
                //check if there are another message
                final nextChatMessage = index + 1 < loadedMessages.length?loadedMessages[index+1].data():null;
                // get current message userId
                final currentMessageuserId = chatMessage['userId'];
                // get next message userId if exist
                final nextMessageuserId = nextChatMessage != null ? nextChatMessage['userId'] : null;
                //compare the two userId
                final nextUserIsSame = currentMessageuserId == nextMessageuserId;
                // isMe will change some styles
                if(nextUserIsSame){
                  return MessageBubble.next(message: chatMessage['text'],isMe: authenticatedUser!.uid == currentMessageuserId);
                }
                else {
                  return MessageBubble.first(userImage: chatMessage['userImage'], username: chatMessage['username'], message: chatMessage['text'], isMe: authenticatedUser!.uid == currentMessageuserId);
                }
              });
        });
  }
}
