// ignore_for_file: avoid_print, unused_import

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //it converts different formats

class Session with ChangeNotifier {
  late String url;
  Map<String, String> headers = {};
  Future<void> logOut() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode != 400) {
      updateCookie(response);
    } else {
      print(response.statusCode);
    }
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
