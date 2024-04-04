// ignore_for_file: prefer_const_constructors

import 'package:attendance/Screen/Auth/change_password.dart';
import 'package:attendance/Screen/TabScreen/profile_screen.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  static String id = "setting";
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              RowItem(
                icon: Icons.key,
                text: 'Change Password',
                onPress: () {
                  Navigator.pushNamed(context, ChangePassword.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
