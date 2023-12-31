// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/screen/home_screen.dart';
import 'package:movie/screen/library_screen.dart';
import 'package:movie/widgets/bottom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  static String id = 'home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // appBar: AppBar(
        //   bottom: TabBar(
        //     tabs: [
        //       Text('Home'),
        //       Text('Library'),
        //     ],
        //   ),
        // ),
        // bottomNavigationBar: Container(
        //   margin: EdgeInsets.only(bottom: 50.0),
        //   width: double.infinity,
        //   padding: EdgeInsets.only(left: 29.0, top: 0.0, right: 29.0),
        //   height: 100.0,
        //   decoration: BoxDecoration(
        //     color: Color(0xFF2B2B2B),
        //     borderRadius: BorderRadius.circular(40.0),
        //   ),
        //   child: Center(
        //     child: BottomNavigationBar(
        //       currentIndex: 2,
        //       backgroundColor: Color(0xFF2B2B2B),
        //       items: [
        //         BottomNavigationBarItem(
        //           backgroundColor: Color(0xFF2B2B2B),
        //           icon: Icon(Icons.home_outlined),
        //           label: 'Home',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: Icon(Icons.circle_outlined),
        //           label: 'Circle',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: Icon(FontAwesomeIcons.clapperboard),
        //           label: 'Library',
        //         ),
        //         // BottomNavigationBarItem(
        //         //   icon: Icon(FontAwesomeIcons.message),
        //         //   label: 'Message',
        //         // ),
        //         // BottomNavigationBarItem(
        //         //   icon: Icon(
        //         //     FontAwesomeIcons.user,
        //         //   ),
        //         //   label: 'Profile',
        //         // ),
        //       ],
        //     ),
        //   ),
        // ),

        body: HomeScreen(),
      ),
    );
  }
}
