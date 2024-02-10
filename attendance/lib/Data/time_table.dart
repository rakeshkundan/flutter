import 'package:flutter/cupertino.dart';

class TimeTable extends ChangeNotifier {
  dynamic scheduleData;
  Future<void> setSchedule(dynamic data) async {
    // print(data['TimeTable']);
    scheduleData = data['TimeTable'];
    // print(scheduleData);
    notifyListeners();
  }

  int activeSection = 0;
  bool progressBar = false;
  bool get isProgress => progressBar;
  void setProgressBar(bool val) {
    progressBar = val;
    notifyListeners();
  }

  void setActiveSection(int value) {
    activeSection = value;
  }
}
