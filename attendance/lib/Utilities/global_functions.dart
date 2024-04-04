import 'package:attendance/models/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalFunction {
  Future<void> logOut() async {
    DatabaseHelper dbHelp = DatabaseHelper.instance;
    bool val = await dbHelp.deleteDb();
    // print(val);
    if (val) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // if (response.statusCode == 200) {
      await prefs.setBool('isLoggedIn', false);
      await prefs.setString('authorization', "");
    }
  }
}
