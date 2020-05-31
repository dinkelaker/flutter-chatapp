import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').snapshots(),
      builder: (ctxt, chatsShapshot) {
        if (chatsShapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var documents = chatsShapshot.data.documents;
        if (documents.length > 0)
          return Expanded(
                      child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctxt, index) => Text(
                documents[index]['text'],
              ),
              reverse: true,
            ),
          );
        else
          return Text('No messages, yet!');
      },
    );
  }
}
