import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/B1AAdHxOosV3SoS7efbr/messages')
            .snapshots(),
        builder: (ctxt, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctxt, index) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/B1AAdHxOosV3SoS7efbr/messages')
              .snapshots()
              .listen(
            (event) {
              print(event);
            },
          );
        },
      ),
    );
  }
}
