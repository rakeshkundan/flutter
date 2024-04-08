// ignore_for_file: avoid_print

import 'package:attendance/Utilities/global_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; //it converts different formats

class NetworkHelper {
  final String url;
  Map<String, String> headers = {
    'user-agent': 'Dart/3.2 (dart:io)',
    'accept-encoding': 'gzip',
    'host': 'http://10.3.1.6'
  };
  final bool head;
  NetworkHelper({required this.url, this.head = false});

  Future getData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authorization = prefs.getString('authorization');
      headers['authorization'] = authorization!;
      http.Response response = head
          ? await http.get(Uri.parse(url), headers: headers)
          : await http.get(
              Uri.parse(url),
            );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        String data = response.body;
        // print(jsonDecode(data));
        return jsonDecode(data);
      } else if (response.statusCode == 403) {
        GlobalFunction gf = GlobalFunction();
        await gf.logOut();
        return "unauthorized";
      } else {
        print(jsonDecode(response.body));
        return "Network Error";
      }
    } catch (e) {
      print(e);
      // print("hello");
      return 'Network Error';
    }
  }

  Future postData(data) async {
    try {
      // print(data);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authorization = prefs.getString('authorization');
      headers['authorization'] = authorization!;
      http.Response response = head
          ? await http.post(
              Uri.parse(url),
              headers: headers,
              body: data,
              encoding: Encoding.getByName('utf-8'),
            )
          : await http.post(
              Uri.parse(url),
              body: data,
              encoding: Encoding.getByName('utf-8'),
            );
      if (response.statusCode == 200) {
        String data = response.body;
        // print(jsonDecode(data));
        return jsonDecode(data);
      } else if (response.statusCode == 403) {
        GlobalFunction gf = GlobalFunction();
        await gf.logOut();
        return "unauthorized";
      } else {
        print(jsonDecode(response.body));
        return "Network Error";
      }
    } catch (e) {
      print(e);
      // print("hello");
      return 'Network Error';
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
