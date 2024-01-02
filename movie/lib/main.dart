// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:movie/data/contact_detail.dart';
import 'package:movie/data/profile_data.dart';
import 'package:movie/data/state_data.dart';
import 'package:movie/models/database.dart';
import 'package:movie/screen/chat_screen.dart';
import 'package:movie/screen/circle_screen.dart';
import 'package:movie/screen/home.dart';
import 'package:movie/screen/home_screen.dart';
import 'package:movie/screen/library_screen.dart';
import 'package:movie/screen/loading_screen.dart';
import 'package:movie/screen/login_screen.dart';
import 'package:movie/screen/message_screen.dart';
import 'package:movie/screen/movie_detail_screen.dart';
import 'package:movie/screen/profile_detail_screen.dart';
import 'package:movie/screen/profile_screen.dart';
import 'package:movie/screen/search_result.dart';
import 'package:movie/utilities/category_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => CategoryList(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => StateData(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProfileData(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ContactDetail(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF1A1A1A),
          appBarTheme: AppBarTheme(
            // backgroundColor: Color(0xFF1A1A1A),
            titleTextStyle: TextStyle(color: Colors.white),
          ),
        ),
        initialRoute: Home.id,
        routes: {
          Home.id: (context) => Home(),
          HomeScreen.id: (context) => HomeScreen(),
          CircleScreen.id: (context) => CircleScreen(),
          LibraryScreen.id: (context) => LibraryScreen(),
          MessageScreen.id: (context) => MessageScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          ProfileDetailScreen.id: (context) => ProfileDetailScreen(),
          MovieDetailScreen.id: (context) => MovieDetailScreen(),
          SearchResult.id: (context) => SearchResult(),
          LoadingScreen.id: (context) => LoadingScreen(),
        },
      ),
    );
  }
}
