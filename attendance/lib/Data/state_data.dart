// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_captcha/local_captcha.dart';

class StateData extends ChangeNotifier {
  ///////?Captcha/////

  final localCaptcha = LocalCaptchaController();
  void refresh() {
    localCaptcha.refresh();
    notifyListeners();
  }

  Map<String, bool> profileEdit = {
    'Name': false,
    'Department': false,
    'EmployeeId': false,
  };
  void setEdit(String key) {
    profileEdit[key] = !profileEdit[key]!;
    notifyListeners();
  }

  bool getEdit(String key) {
    return profileEdit[key]!;
  }

  int reviewCount = 0;
  void reviewCountUpdate(int x) {
    reviewCount = x;
    notifyListeners();
  }

  int active = 0;

  ////////Calendar/////
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime get selected => selectedDay;
  Future<void> setDay(DateTime selected, DateTime focused) async {
    selectedDay = selected;
    focusedDay = focused;
    // print(selected.weekday);
    notifyListeners();
  }
}
