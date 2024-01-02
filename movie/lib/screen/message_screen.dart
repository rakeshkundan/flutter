// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movie/components/app_title.dart';
import 'package:movie/data/contact_detail.dart';
import 'package:movie/models/database.dart';
import 'package:movie/screen/chat_screen.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatelessWidget {
  static String id = 'message_screen';

  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          AppTitle(
            titleText: 'Messages',
            titleIcon: Icons.mail_outline,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Provider.of<ContactDetail>(context).contactList.length,
              itemBuilder: (context, index) {
                var data =
                    Provider.of<ContactDetail>(context).contactList[index];
                return ContactTile(
                  name: data['cname'],
                  lastMessage: data['lmessage'],
                  unreadCount: data['unreadCount'],
                  number: data['cnum'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final String name;
  final int unreadCount;
  final String lastMessage;
  final String number;
  const ContactTile(
      {super.key,
      this.name = '',
      this.lastMessage = '',
      this.unreadCount = 0,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.id);
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lastMessage,
                        style: TextStyle(
                          color: Color(0xff39c4a6),
                        ),
                      ),
                      (unreadCount > 0)
                          ? CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.red,
                              child: Text(
                                '$unreadCount',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
