// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:attendance/Data/profile_data.dart';
import 'package:attendance/Data/state_data.dart';
import 'package:attendance/Data/student_detail.dart';
import 'package:attendance/Data/time_table.dart';
import 'package:attendance/Screen/Auth/change_password.dart';
import 'package:attendance/Screen/SupportScreen/analysis_detail_finder.dart';
import 'package:attendance/Screen/SupportScreen/analysis_screen.dart';
import 'package:attendance/Screen/SupportScreen/attendance_download_screen.dart';
import 'package:attendance/Screen/SupportScreen/attendance_percentage_list.dart';
import 'package:attendance/Screen/SupportScreen/attendance_screen.dart';
import 'package:attendance/Screen/SupportScreen/setting.dart';
import 'package:attendance/Screen/SupportScreen/student_summary_screen.dart';
import 'package:attendance/Screen/initial_screen.dart';
import 'package:attendance/Screen/Auth/login_screen.dart';
import 'package:attendance/Screen/SupportScreen/profile_detail_screen.dart';
import 'package:attendance/Screen/TabScreen/profile_screen.dart';
import 'package:attendance/Screen/TabScreen/schedule_screen.dart';
import 'package:attendance/Screen/TabScreen/dashboard_screen.dart';
import 'package:attendance/Screen/home.dart';
import 'package:attendance/Screen/loading_screen.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => StateData(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => TimeTable(),
        ),
        ChangeNotifierProvider(
          create: (context) => StudentDetail(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileData(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(primaryColor: kInactiveTextColor),
        initialRoute: InitialScreen.id,
        routes: {
          Home.id: (context) => const Home(),
          InitialScreen.id: (context) => InitialScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          ChangePassword.id: (context) => ChangePassword(),
          ScheduleScreen.id: (context) => ScheduleScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          LoadingScreen.id: (context) => const LoadingScreen(),
          DashboardScreen.id: (context) => DashboardScreen(),
          AnalysisDetailFinderScreen.id: (context) =>
              AnalysisDetailFinderScreen(),
          AnalysisScreen.id: (context) => AnalysisScreen(),
          AttendancePercentageList.id: (context) => AttendancePercentageList(),
          StudentSummaryScreen.id: (context) => StudentSummaryScreen(),
          AttendanceDownloadScreen.id: (context) => AttendanceDownloadScreen(),
          AttendanceScreen.id: (context) => AttendanceScreen(),
          ProfileDetailScreen.id: (context) => ProfileDetailScreen(),
          Setting.id: (context) => Setting(),
        },
      ),
    );
  }
}
