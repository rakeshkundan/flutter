// ignore_for_file: unused_import

import 'package:attendance/Data/profile_data.dart';
import 'package:attendance/Data/state_data.dart';
import 'package:attendance/Data/time_table.dart';
import 'package:attendance/Screen/home.dart';
import 'package:attendance/Screen/Auth/login_screen.dart';
import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/constants.dart';
import 'package:attendance/models/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatefulWidget {
  static String id = 'initial_screen';
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  void firstTimeChecker() async {
    await Provider.of<ProfileData>(context, listen: false).setData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    // isLoggedIn = true;
    if (isLoggedIn != null && isLoggedIn) {
      if (!mounted) return;
      NetworkHelper nethelp = NetworkHelper(
        url:
            "$kScheduleLink?day=${Provider.of<StateData>(context, listen: false).selectedDay.weekday}",
        head: true,
      );

      var data = await nethelp.getData();
      // print(data);
      // if (data != " Network Error") {
      if (!mounted) return;
      await Provider.of<TimeTable>(context, listen: false).setSchedule(data);
      // }
      if (!mounted) return;
      Navigator.popAndPushNamed(context, Home.id);
    } else {
      if (!mounted) return;
      Navigator.popAndPushNamed(context, LoginScreen.id);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
// your code goes here
      firstTimeChecker();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.grey.shade700,
          size: 70,
        ),
      ),
    );
  }
}
