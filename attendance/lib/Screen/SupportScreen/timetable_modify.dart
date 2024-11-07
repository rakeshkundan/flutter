// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unnecessary_null_comparison

import 'dart:convert';
import 'package:attendance/admin/screen/edit_data_page.dart';
import 'package:attendance/components/input_box.dart';
import 'package:attendance/components/schedule_card.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimetableModify extends StatefulWidget {
  static String id = 'timetable_modify';
  const TimetableModify({super.key});

  @override
  State<TimetableModify> createState() => _ModifyTimetableState();
}

class _ModifyTimetableState extends State<TimetableModify> {
  TextEditingController employeeCode = TextEditingController();
  bool loading = false;
  String day = "";
  List<Widget> list = [];
  Future<void> scheduleMaker(BuildContext context) async {
    setState(() {
      loading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authorization = prefs.getString('authorization');
    var response = await http.post(
      Uri.parse("$kAdminPath/getTimetable"),
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "authorization": authorization ?? "",
      },
      body: jsonEncode({"employeeCode": employeeCode.text, "day": day}),
      encoding: Encoding.getByName('utf-8'),
    );
    var data = response != null ? jsonDecode(response.body) : {};
    if (response.statusCode == 200) {
      var tmpList = data['TimeTable'];
      list = [];
      list.add(Text(
        "Schedule:",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ));
      for (var item in tmpList) {
        list.add(
          ScheduleCard(
            data: item,
            onTap: () {
              // Navigator.pushNamed(context, EditDataPage.id,
              // arguments: {"employeeCode": employeeCode.text, "data": item});
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditDataPage(
                            employeeCode: employeeCode.text,
                            data: item,
                          )));
            },
          ),
        );
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Modify Timetable"),
        ),
        body: ModalProgressHUD(
          inAsyncCall: loading,
          child: SizedBox(
            height: double.infinity,
            child: SizedBox(
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // InputBox(
                  //   textController: employeeCode,
                  //   label: "EmployeeCode",
                  // ),
                  Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: kInactiveTextColor),
                    ),
                    child: DropdownButton(
                      style: TextStyle(
                          color: kInactiveTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      isExpanded: true,
                      value: day,
                      onChanged: (x) {
                        setState(() {
                          day = x!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: "",
                          child: Text("Select Day"),
                        ),
                        DropdownMenuItem(
                          value: "1",
                          child: Text("Monday"),
                        ),
                        DropdownMenuItem(
                          value: "2",
                          child: Text("Tuesday"),
                        ),
                        DropdownMenuItem(
                          value: "3",
                          child: Text("Wednesday"),
                        ),
                        DropdownMenuItem(
                          value: "4",
                          child: Text("Thursday"),
                        ),
                        DropdownMenuItem(
                          value: "5",
                          child: Text("Friday"),
                        ),
                        DropdownMenuItem(
                          value: "6",
                          child: Text("Saturday"),
                        ),
                        DropdownMenuItem(
                          value: "7",
                          child: Text("Sunday"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                    child: TextButton(
                      onPressed: () async {
                        await scheduleMaker(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: list,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
