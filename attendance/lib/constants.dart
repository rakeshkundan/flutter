// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

const kInactiveTextColor = Color(0xFF505052);
// String kBaseLink =
//     Platform.isIOS ? 'http://10.3.1.6:3000' : 'http://10.3.1.6:3000';
// String kScheduleLink = Platform.isIOS
//     ? 'http://10.3.1.6:3000/api/timetable/timeTable'
//     : 'http://10.3.1.6:3000/api/timetable/timeTable';

String kBaseLink =
    Platform.isIOS ? 'http://localhost:3000' : 'http://localhost:3000';
// String kScheduleLink =
//     "https://n1znsm3p-80.inc1.devtunnels.ms/api/timetable/timeTable";
String kScheduleLink = Platform.isIOS
    ? 'http://localhost:3000/api/timetable/timeTable'
    : 'http://localhost:3000/api/timetable/timeTable';

TextStyle kAlertButtonTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.grey.shade700,
  backgroundColor: Colors.transparent,
);

const kDebugMode = true;
