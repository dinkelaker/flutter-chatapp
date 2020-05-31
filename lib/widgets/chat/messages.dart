import 'package:chatapp/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctxt, chatsShapshot) {
        if (chatsShapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var documents = chatsShapshot.data.documents;
        if (documents.length > 0)
          return Expanded(
            child: FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (ctxt, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (ctxt, index) => MessageBubble(
                    documents[index]['text'],
                    documents[index]['userId'],
                    documents[index]['userId'] == futureSnapshot.data.uid,
                    key: ValueKey(documents[index]['documentId']),
                  ),
                  reverse: true,
                );
              },
            ),
          );
        else
          return Text('No messages, yet!');
      },
    );
  }
}
