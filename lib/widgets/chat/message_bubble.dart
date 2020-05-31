import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userId, this.isCurrentUser, {this.key});

  final String message;
  final String userId;
  final bool isCurrentUser;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? Colors.grey[600]
                  : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft:
                    !isCurrentUser ? Radius.circular(0) : Radius.circular(12),
                bottomRight:
                    isCurrentUser ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            width: 240,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end :  CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder(
                  future: Firestore.instance.collection('users').document(userId).get(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...');
                    }                      
                    return Text(snapshot.data['username'],
                        style: TextStyle(
                          color: Theme.of(context).accentTextTheme.headline1.color ,
                          fontWeight: FontWeight.bold,
                        ));
                  }
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: Theme.of(context).accentTextTheme.headline1.color),
                  textAlign: isCurrentUser? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
        ]);
  }
}
