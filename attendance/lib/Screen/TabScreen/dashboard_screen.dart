// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_import, unnecessary_import, avoid_unnecessary_containers

import 'package:attendance/Screen/attendance_download_screen.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static String id = "dashboard_screen";
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                DashboardCard(
                  onClick: () {
                    Navigator.pushNamed(context, AttendanceDownloadScreen.id);
                  },
                  icon: Icons.poll_outlined,
                  title: "Attendance",
                ),
                DashboardCard(
                  icon: Icons.analytics,
                  title: "Analysis",
                ),
                // DashboardCard(),
                // DashboardCard(),
                // DashboardCard(),
                // DashboardCard(),
                // DashboardCard(),
                // DashboardCard(),
                // DashboardCard(),
                // DashboardCard(),
                // DashboardCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onClick;
  const DashboardCard({
    super.key,
    this.icon = Icons.rectangle,
    this.title = "This Is Title",
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: width * .43,
        child: Material(
          elevation: 7,
          borderRadius: BorderRadius.circular(.025 * width),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: .06 * width, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(40),
                  elevation: 7,
                  child: CircleAvatar(
                    radius: .08 * width,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      icon,
                      size: .1 * width,
                      color: kInactiveTextColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: .05 * width,
                    fontWeight: FontWeight.w600,
                    color: kInactiveTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
