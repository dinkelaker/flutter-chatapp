import 'package:chatapp/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctxt, userDataFuture) {
        if (userDataFuture.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (ctxt, chatDocumentsShapshot) {
            if (chatDocumentsShapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var documents = chatDocumentsShapshot.data.documents;
            if (documents.length > 0)
              return Expanded(
                  child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (ctxt, index) { 
                  return MessageBubble(
                  documents[index]['text'],
                  documents[index]['username'],
                  documents[index]['userId'] == userDataFuture.data.uid,
                  key: ValueKey(documents[index].documentID),
                );},
                reverse: true,
              ));
            else
              return Text('No messages, yet!');
          },
        );
      },
    );
  }
}
