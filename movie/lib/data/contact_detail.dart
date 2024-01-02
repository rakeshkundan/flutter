// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:movie/models/database.dart';

class ContactDetail extends ChangeNotifier {
  List<Map<String, dynamic>> contactList = [];
  void getData() async {
    DatabaseHelper dbHelp = DatabaseHelper.instance;
    contactList = await dbHelp.querryAllContact();
    notifyListeners();
    // print(contactList);
  }

  ContactDetail() {
    getData();
  }
}
