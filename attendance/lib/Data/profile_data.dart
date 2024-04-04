import 'package:flutter/foundation.dart';
import 'package:attendance/models/database.dart';
import 'package:attendance/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileData extends ChangeNotifier {
  Map<String, String> profile = {
    'Name': 'Username',
    'Department': '',
    'EmployeeId': ''
  };
  bool profileSet = false;
  Future<void> setData() async {
    DatabaseHelper dbHelp = DatabaseHelper.instance;

    final prefs = await SharedPreferences.getInstance();
    if (await dbHelp.queryRowCountUser() != 0) {
      var data = await dbHelp.queryAllRowsUser();
      // print(data);
      profile['Name'] = data[0]['name'] ?? 'Username';
      profile['Department'] = data[0]['department'] ?? 'Online';
      profile['EmployeeId'] = data[0]['employeeId'] ?? '123456789';
    }
    profileSet = prefs.getBool('profileSet') ?? false;
    notifyListeners();
  }

  void updateData(String key, String value) async {
    Map<String, String> mp = {
      ...profile,
      key: value,
    };
    // ignore: unused_local_variable
    User user = User(mp['Name']!, mp['Department']!, mp['EmployeeId']!);
    await setData();
  }

  ProfileData() {
    setData();
  }

  String? get name => profile['Name'];
  String? get department => profile['Department'];
  String? get employeeId => profile['EmployeeId'];
  bool get isProfileSet => profileSet;
  Future<void> setIsProfileSet(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', val);
    await setData();
    profileSet = val;
  }
}
