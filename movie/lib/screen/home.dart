// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/screen/circle_screen.dart';
import 'package:movie/screen/home_screen.dart';
import 'package:movie/screen/library_screen.dart';
import 'package:movie/screen/loading_screen.dart';
import 'package:movie/screen/message_screen.dart';
import 'package:movie/screen/profile_screen.dart';
import 'package:movie/widgets/bottom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  static String id = 'home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              TabBarView(
                children: [
                  HomeScreen(),
                  CircleScreen(),
                  LibraryScreen(),
                  MessageScreen(),
                  ProfileScreen(),
                ],
              ),
              Positioned(
                bottom: 25.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.only(left: 29.0, top: 0.0, right: 29.0),
                  height: 75.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF2B2B2B),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: kIconColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    unselectedLabelColor: kInactiveTextColor,
                    indicatorColor: kIconColor,
                    labelColor: kIconColor,
                    dividerColor: Colors.transparent,
                    labelPadding: EdgeInsets.all(0),
                    tabs: [
                      Tab(
                        iconMargin: EdgeInsets.only(
                          top: 0,
                        ),
                        text: 'Home',
                        icon: Icon(
                          Icons.home_outlined,
                        ),
                      ),
                      Tab(
                        iconMargin: EdgeInsets.only(
                          top: 0,
                        ),
                        text: 'Circles',
                        icon: Icon(FontAwesomeIcons.circle),
                      ),
                      Tab(
                        iconMargin: EdgeInsets.only(
                          top: 0,
                        ),
                        text: 'Library',
                        icon: Icon(FontAwesomeIcons.clapperboard),
                      ),
                      Tab(
                        iconMargin: EdgeInsets.only(
                          top: 0,
                        ),
                        text: 'Chats',
                        icon: Icon(FontAwesomeIcons.message),
                      ),
                      Tab(
                        iconMargin: EdgeInsets.only(
                          top: 0,
                        ),
                        text: 'Profile',
                        icon: Icon(FontAwesomeIcons.user),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class Home extends StatelessWidget {
//
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
