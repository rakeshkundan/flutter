// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; //it converts different formats

class NetworkHelper {
  final String url;
  Map<String, String> headers = {
    'user-agent': 'Dart/3.2 (dart:io)',
    'accept-encoding': 'gzip',
    'host': 'https://n1znsm3p-80.inc1.devtunnels.ms'
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
      if (response.statusCode == 200) {
        String data = response.body;
        // print(jsonDecode(data));
        return jsonDecode(data);
      } else {
        // print(jsonDecode(response.body));
        return "Network Error";
      }
    } catch (e) {
      print(e);
      return 'Network Error';
    }
  }

  Future postData(String postUrl, String phone, String pass) async {
    print(phone + pass);
    http.Response response = await http.post(Uri.parse(postUrl),
        headers: {"content-type": "application/json"},
        body: jsonEncode({'phone': phone, 'password': pass}));
    if (response.statusCode == 200) {
      String data = response.body;
      updateCookie(response);
      return jsonDecode(data);
    } else {
      return response.statusCode;
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
