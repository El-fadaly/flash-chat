import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessagesStream extends StatelessWidget {
  MessagesStream({@required this.loggedInUserEmail});

  final String loggedInUserEmail;

  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueGrey,
              ),
            ),
          );
        }

        final messageData = snapshot.data.docs;
        List<MessageBubble> messageBubbles = [];
        for (var message in messageData) {
          var sender = message.data()['sender'];
          var text = message.data()['text'];
          print('$text from $sender');

          if (text != null && sender != null)
            messageBubbles.add(
              MessageBubble(
                sender: sender,
                text: text,
                isLogged: loggedInUserEmail == sender,
              ),
            );
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
