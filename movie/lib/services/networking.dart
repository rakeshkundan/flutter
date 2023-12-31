// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert'; //it converts different formats

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future getData() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
