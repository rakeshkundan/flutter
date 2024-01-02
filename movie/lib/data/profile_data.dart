// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:movie/models/database.dart';
import 'package:movie/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileData extends ChangeNotifier {
  Map<String, String> profile = {'Name': 'Username', 'About': '', 'Phone': ''};
  bool profileSet = false;
  Future<void> setData() async {
    DatabaseHelper dbHelp = DatabaseHelper.instance;

    final prefs = await SharedPreferences.getInstance();
    if (await dbHelp.queryRowCountUser() != 0) {
      var data = await dbHelp.queryAllRowsUser();

      profile['Name'] = data[0]['name'] ?? 'Username';
      profile['About'] = data[0]['about'] ?? 'Online';
      profile['Phone'] = data[0]['phone'] ?? 'Phone';
    }
    profileSet = prefs.getBool('profileSet') ?? false;
    notifyListeners();
  }

  void updateData(String key, String value) async {
    DatabaseHelper dbHelp = DatabaseHelper.instance;
    Map<String, String> mp = {
      ...profile,
      key: value,
    };
    User user = User(mp['Name']!, mp['About']!, mp['Phone']!);
    final rowsAffected = await dbHelp.updateUser(user);
    await setData();
  }

  ProfileData() {
    setData();
  }

  String? get name => profile['Name'];
  String? get about => profile['About'];
  String? get phone => profile['Phone'];
  bool get isProfileSet => profileSet;
  Future<void> setIsProfileSet(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('profileSet', val);
    await setData();
    profileSet = val;
  }
}
