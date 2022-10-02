import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreen createState() => _MessagesScreen();
}

class _MessagesScreen extends State<MessagesScreen> {
 
 ChatUser thisUser = ChatUser(
      id: '1',
      firstName: 'Charles',
      lastName: 'Leclerc',
    );

    ChatUser oppositeUser = ChatUser(
      id: '2',
      firstName: 'Cool',
      lastName: 'Kid',
    );

  late List<ChatMessage> messages = <ChatMessage>[
      ChatMessage(
        text: 'Hey!',
        user: thisUser,
        createdAt: DateTime.now(),
      ),
      ChatMessage(
        text: 'Hi!',
        user: oppositeUser,
        createdAt:DateTime.now()
      )
    ];
  
  
  

  @override
  Widget build(BuildContext context) {
    String title = "";
    if(oppositeUser.firstName != null && oppositeUser != null) {
      title = oppositeUser.firstName.toString() + " " + oppositeUser.lastName.toString();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(title),
      ),
      body: DashChat(
        currentUser: thisUser,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });
        },
        messages: messages,
      ),
    );
  }
}