import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctxt, index) => Container(
        padding: EdgeInsets.all(8),
        child: Text('This works'),
      ),
    );
  }
}
