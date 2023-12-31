// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/data/app_title.dart';
import 'package:movie/data/profile_data.dart';
import 'package:movie/models/database.dart';
import 'package:movie/models/user.dart';
import 'package:movie/screen/profile_screen.dart';
import 'package:movie/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var data = '';
  final dbHelper = DatabaseHelper.instance;

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
                  titleText: 'Authentication',
                  titleIcon: Icons.login,
                ),
                TextField(
                  onChanged: (value) {
                    data = value;
                  },
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    icon: Text(
                      '+91',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: kIconColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: kIconColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RawMaterialButton(
                  onPressed: () async {
                    try {
                      if (kDebugMode) {
                        // print(data);
                      }
                      Map<String, dynamic> row = {
                        DatabaseHelper.phone: data,
                        DatabaseHelper.about: 'online',
                        DatabaseHelper.name: 'User 101',
                      };
                      User user = User.fromMap(row);
                      final id = await dbHelper.insertUser(user);
                      if (!context.mounted) return;
                      await Provider.of<ProfileData>(context, listen: false)
                          .setIsProfileSet();
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, ProfileScreen.id);
                    } catch (e) {
                      // print(e);
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 40,
                    color: kInactiveTextColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Icon(Icons.login_outlined)
                      ],
                    ),
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
