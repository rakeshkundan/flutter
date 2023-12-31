// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movie/data/app_title.dart';
import 'package:movie/widgets/bottom_nav_bar.dart';
import 'package:movie/widgets/search_bar.dart';

class LibraryScreen extends StatelessWidget {
  static String id = 'library_screen';
  const LibraryScreen({super.key});

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
                  titleText: 'Library',
                  titleIcon: Icons.add,
                ),
                Searchbar(
                  hintText: 'Search for movie',
                ),
                Text('This page is Empty')
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
