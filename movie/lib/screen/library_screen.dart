// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movie/components/app_title.dart';
import 'package:movie/widgets/search_bar.dart';

class LibraryScreen extends StatelessWidget {
  static String id = 'library_screen';
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
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
    );
  }
}
