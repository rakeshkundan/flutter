import 'package:attendance/Data/profile_data.dart';
import 'package:attendance/Screen/home.dart';
import 'package:attendance/Screen/Auth/login_screen.dart';
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
    // isLoggedIn = false;
    if (isLoggedIn != null && isLoggedIn) {
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
      firstTimeChecker();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: "ManitLogo",
          transitionOnUserGestures: true,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 90,
            child: Image.asset('./assets/images/manit_logo.jpg'),
          ),
        ),
        const SizedBox(
          height: 140,
        ),
        SpinKitFadingCircle(
          color: Colors.grey.shade700,
          size: 70,
        ),
      ],
    ));
  }
}
