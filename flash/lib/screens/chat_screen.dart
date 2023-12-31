// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flash/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String messageText;

  void getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   await _firestore.collection('messages').get().then((value) {
  //     for (var messages in value.docs) {
  //       print(messages.data());
  //     }
  //   });
  // }
  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var messages in snapshot.docs) {
  //       print(messages.data());
  //     }
  //   }
  // }

  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                // messageStream();
                setState(() {
                  showSpinner = true;
                });
                await _auth.signOut();
                if (!context.mounted) return;
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, WelcomeScreen.id);
                setState(() {
                  showSpinner = true;
                });
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(),
              Container(
                decoration: kMessageContainerDecoration,
                alignment: Alignment.topRight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          //Do something with the user input.
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //Implement send functionality.
                        _firestore.collection('messages').add({
                          'datetime': DateTime.now().toString(),
                          'text': messageText,
                          'sender': loggedInUser.email,
                        });
                        messageController.clear();
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore
          .collection('messages')
          .orderBy('datetime', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = (snapshot.data?.docs);

          List<MessageBubble> messageBubble = [];
          for (var message in messages!) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final currentUser = loggedInUser.email;
            if (currentUser == messageSender) {
              //the message from the logged in user
            }
            messageBubble.add(MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            ));
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              scrollDirection: Axis.vertical,
              children: messageBubble,
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String? text;
  final String? sender;
  final bool isMe;
  const MessageBubble(
      {super.key,
      this.text = 'message',
      this.sender = 'sender',
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(color: Colors.black),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlue : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                '$text',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
