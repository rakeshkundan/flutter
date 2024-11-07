// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:attendance/Data/state_data.dart';
import 'package:attendance/components/input_box.dart';
import 'package:attendance/components/schedule_card.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Replacement extends StatefulWidget {
  static String id = "replace_faculty";
  final dynamic data;
  const Replacement({super.key, this.data = 0});

  @override
  State<Replacement> createState() => _ReplacementState();
}

class _ReplacementState extends State<Replacement> {
  TextEditingController empCode = TextEditingController();
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Replacement"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          ScheduleCard(index: 0, data: widget.data, onTap: () {}),
          SizedBox(
            height: 100,
          ),
          InputBox(
            textController: empCode,
            label: "Enter Employee Code",
          ),
          SizedBox(
            height: 20,
          ),
          RawMaterialButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () async {
              if (empCode.text == "") {
                return;
              }
              print(Provider.of<StateData>(context, listen: false).focusedDay);
              var data = {
                "subject": widget.data,
                "requested": empCode.text,
                "date": Provider.of<StateData>(context, listen: false)
                    .focusedDay
                    .toString()
              };
              // print(data);
              String url = "$kBaseLink/api/timetable/replacement";
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              String auth = prefs.getString('authorization') ?? "";
              var response = await http.post(
                Uri.parse(url),
                headers: {
                  "Accept": "*/*",
                  "Content-Type": "application/json",
                  "authorization": auth
                },
                body: jsonEncode(data),
                encoding: Encoding.getByName('utf-8'),
              );
              var resp = jsonDecode(response.body);
              if (resp["message"] == "Success") {
                if (!context.mounted) {
                  return;
                }
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Alert!'),
                      content: const Text('Requested successfully'),
                      actions: [
                        RawMaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // color: kInactiveTextColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 7.0),
                            child: Text(
                              'Ok',
                              style: kAlertButtonTextStyle,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              setState(() {
                empCode.text = "";
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              child: Text(
                'Send Request',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
