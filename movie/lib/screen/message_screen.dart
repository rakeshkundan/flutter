// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movie/data/app_title.dart';
import 'package:movie/screen/chat_screen.dart';
import 'package:movie/widgets/bottom_nav_bar.dart';

class MessageScreen extends StatelessWidget {
  static String id = 'message_screen';
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                AppTitle(
                  titleText: 'Messages',
                  titleIcon: Icons.mail_outline,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ContactTile(),
                      ContactTile(),
                      ContactTile(),
                      ContactTile(),
                      ContactTile(),
                      ContactTile(),
                      ContactTile(),
                      ContactTile(),
                      ContactTile(),
                      ContactTile(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 25.0,
              left: 0.0,
              right: 0.0,
              child: BottomNavBar(),
            )
          ],
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({super.key});

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
                    'Rakesh kundan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Divyanshu: hii',
                        style: TextStyle(
                          color: Color(0xff39c4a6),
                        ),
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.red,
                        child: Text(
                          '32',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
