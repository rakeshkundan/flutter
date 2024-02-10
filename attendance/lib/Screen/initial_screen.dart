import 'package:attendance/Data/profile_data.dart';
import 'package:attendance/Data/state_data.dart';
import 'package:attendance/Data/time_table.dart';
import 'package:attendance/Screen/home.dart';
import 'package:attendance/Screen/intro_screen.dart';
import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/constants.dart';
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

      await Provider.of<TimeTable>(context, listen: false)
          .setSchedule(await nethelp.getData());
      if (!mounted) return;
      Navigator.popAndPushNamed(context, Home.id);
    } else {
      if (!mounted) return;
      Navigator.popAndPushNamed(context, IntroScreen.id);
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
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.grey.shade700,
          size: 70,
        ),
      ),
    );
  }
}