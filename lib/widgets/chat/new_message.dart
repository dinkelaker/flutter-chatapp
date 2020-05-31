import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();

  String _enteredMessage = '';

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'Send'),
                  onEditingComplete: _sendMessage,
                  onChanged: (value) {
                    setState(() {
                      _enteredMessage = value;
                    });
                  }),
            ),
            IconButton(
              icon: Icon(Icons.send),
              // only enable send function if send field is not empty
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            ),
          ],
        ));
  }
}
