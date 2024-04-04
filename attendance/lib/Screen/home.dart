import 'package:attendance/Screen/TabScreen/profile_screen.dart';
import 'package:attendance/Screen/TabScreen/schedule_screen.dart';
import 'package:attendance/Screen/TabScreen/dashboard_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static String id = "home";
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          indicator: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
          ),
          tabs: [
            Tab(
              iconMargin: EdgeInsets.only(
                top: 0,
              ),
              text: 'Schedule',
              icon: Icon(
                Icons.calendar_today,
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.only(
                top: 0,
              ),
              text: 'Dashboard',
              icon: Icon(
                Icons.add_chart,
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.only(
                top: 0,
              ),
              text: 'Profile',
              icon: Icon(
                Icons.person,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            const ScheduleScreen(),
            const DashboardScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
