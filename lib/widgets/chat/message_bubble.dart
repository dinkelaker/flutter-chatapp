import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.isCurrentUser);

  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.grey[600] : Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        width: 140,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Text(
          message,
          style: TextStyle(
              color: Theme.of(context).accentTextTheme.headline1.color),
        ),
      ),
    ]);
  }
}
