// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

const kInactiveTextColor = Color(0xFF505052);
// String kBaseLink = "https://n1znsm3p-80.inc1.devtunnels.ms";
String kBaseLink =
    Platform.isIOS ? 'http://192.169.0.104' : 'http://192.169.0.104';
// String kScheduleLink =
//     "https://n1znsm3p-80.inc1.devtunnels.ms/api/timetable/timeTable";
String kScheduleLink = Platform.isIOS
    ? 'http://192.169.0.104/api/timetable/timeTable'
    : 'http://192.169.0.104/api/timetable/timeTable';
TextStyle kAlertButtonTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.grey.shade700,
  backgroundColor: Colors.transparent,
);
