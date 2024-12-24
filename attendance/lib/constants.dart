import 'package:flutter/material.dart';
import 'dart:io' show Platform;

// const kDebugMode = false;
const kInactiveTextColor = Color(0xFF505052);
// String kBaseLink = 'http://10.3.1.58:5004';
// String kScheduleLink = 'http://10.3.1.58:5004/api/timetable/timeTable';

//
String kBaseLink =
    Platform.isIOS ? 'http://localhost:3000' : 'http://10.0.2.2:3000';
String kScheduleLink = Platform.isIOS
    ? 'http://localhost:3000/api/timetable/timeTable'
    : 'http://10.0.2.2:3000/api/timetable/timeTable';
String kAdminPath = Platform.isIOS
    ? 'http://localhost:3000/api/admin'
    : 'http://10.0.2.2:3000/api/admin';

// String kBaseLink = Platform.isIOS
//     ? 'http://122.175.151.80:3000'
//     : 'http://122.175.151.80:3000';
// // String kScheduleLink =
// //     "https://n1znsm3p-80.inc1.devtunnels.ms/api/timetable/timeTable";
// String kScheduleLink = Platform.isIOS
//     ? 'http://122.175.151.80:3000/api/timetable/timeTable'
//     : 'http://122.175.151.80:3000/api/timetable/timeTable';
// String kAdminPath = Platform.isIOS
//     ? 'http://122.175.151.80:3000/api/admin/'
//     : 'http://122.175.151.80:3000/api/admin/';

TextStyle kAlertButtonTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.grey.shade700,
  backgroundColor: Colors.transparent,
);

const kDebugMode = true;
