// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie/constants.dart';
import 'package:movie/models/database.dart';
import 'package:movie/screen/message_screen.dart';

class LoadingScreen extends StatefulWidget {
  static String id = 'loading_screen';
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void redirectPath() async {
    DatabaseHelper dbHelp = DatabaseHelper.instance;
    var data = await dbHelp.querryAllContact();
    if (!mounted) return;
    Navigator.pushNamed(context, MessageScreen.id, arguments: {'data': data});
  }

  @override
  void initState() {
    // TODO: implement initState
    redirectPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitFadingCircle(
        color: kIconColor,
      )),
    );
  }
}
