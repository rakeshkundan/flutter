// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String titleText;
  final IconData titleIcon;
  final VoidCallback onIconPress;
  void fun() {}

  AppTitle({
    super.key,
    this.titleText = 'Title',
    this.titleIcon = Icons.rectangle_outlined,
    VoidCallback? onIconPress,
  }) : onIconPress = onIconPress ?? (() {});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: onIconPress,
            child: Icon(
              titleIcon,
              size: 25.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
