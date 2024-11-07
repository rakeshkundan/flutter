// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:attendance/components/input_box.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddTimetable extends StatefulWidget {
  static String id = "add_timetable";
  const AddTimetable({super.key});

  @override
  State<AddTimetable> createState() => _AddTimetableState();
}

class _AddTimetableState extends State<AddTimetable> {
  TextEditingController employeeCode = TextEditingController();
  TextEditingController subCode = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController timing = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController session = TextEditingController();
  String semValue = "x", section = "";
  String day = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Timetable"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputBox(
              textController: employeeCode,
              label: "Employee code",
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: InputDecorator(
                decoration: InputDecoration(
                  label: Text(
                    "Day",
                    style: TextStyle(fontSize: 25),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: DropdownButton(
                  underline: SizedBox(),
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
                      value: "0",
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
            ),
            InputBox(
              textController: subCode,
              label: "Subject Code(Like 'CSE321')",
            ),
            InputBox(
              textController: branch,
              label: "Branch (Like 'CSE')",
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: InputDecorator(
                decoration: InputDecoration(
                  label: Text(
                    "Semester",
                    style: TextStyle(fontSize: 25),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: DropdownButton(
                  underline: SizedBox(),
                  style: TextStyle(
                      color: kInactiveTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  isExpanded: true,
                  onChanged: (x) {
                    setState(() {
                      semValue = x!;
                    });
                  },
                  value: semValue,
                  items: [
                    DropdownMenuItem(
                      value: "x",
                      child: Text("Select Semester"),
                    ),
                    DropdownMenuItem(
                      value: "i",
                      child: Text("I"),
                    ),
                    DropdownMenuItem(
                      value: "ii",
                      child: Text("II"),
                    ),
                    DropdownMenuItem(
                      value: "iii",
                      child: Text("III"),
                    ),
                    DropdownMenuItem(
                      value: "iv",
                      child: Text("IV"),
                    ),
                    DropdownMenuItem(
                      value: "v",
                      child: Text("V"),
                    ),
                    DropdownMenuItem(
                      value: "vi",
                      child: Text("VI"),
                    ),
                    DropdownMenuItem(
                      value: "vii",
                      child: Text("VII"),
                    ),
                    DropdownMenuItem(
                      value: "viii",
                      child: Text("VIII"),
                    ),
                  ],
                ),
              ),
            ),
            InputBox(
              textController: timing,
              label: "Timing (Like:12:00-1:00PM)",
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: InputDecorator(
                decoration: InputDecoration(
                  label: Text(
                    "Section",
                    style: TextStyle(fontSize: 25),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: DropdownButton(
                  underline: SizedBox(),
                  style: TextStyle(
                      color: kInactiveTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  isExpanded: true,
                  value: section,
                  onChanged: (x) {
                    setState(() {
                      section = x!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: "",
                      child: Text("Section"),
                    ),
                    DropdownMenuItem(
                      value: "01",
                      child: Text("01"),
                    ),
                    DropdownMenuItem(
                      value: "02",
                      child: Text("02"),
                    ),
                    DropdownMenuItem(
                      value: "03",
                      child: Text("03"),
                    ),
                    DropdownMenuItem(
                      value: "04",
                      child: Text("04"),
                    ),
                    DropdownMenuItem(
                      value: "05",
                      child: Text("05"),
                    ),
                  ],
                ),
              ),
            ),
            InputBox(
              textController: location,
              label: "Location",
            ),
            InputBox(
              textController: course,
              label: "Course (Like:B-tech)",
            ),
            InputBox(
              textController: session,
              label: "Session(like:2021-25)",
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Add Timetable'),
                      content: Text('Are you Sure?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            var data = {
                              "employeeCode": employeeCode.text,
                              "day": day,
                              "subjectCode": subCode.text,
                              "branch": branch.text,
                              "semester": semValue,
                              "timing": timing.text,
                              "section": section,
                              "location": location.text,
                              "session": session.text,
                              "course": course.text
                            };
                            print(data);

                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? authorization =
                                prefs.getString('authorization');
                            var response = await http.post(
                              Uri.parse("$kAdminPath/addTimeTable"),
                              headers: {
                                "Accept": "*/*",
                                "Content-Type": "application/json",
                                "authorization": authorization ?? "",
                              },
                              body: jsonEncode(data),
                              encoding: Encoding.getByName('utf-8'),
                            );
                            // print(response.body);
                            if (response.statusCode == 200) {
                              if (!context.mounted) return;
                              Navigator.pop(context);
                            }
                            if (!context.mounted) return;
                            Navigator.pop(context);
                          },
                          child: Text('Yes'),
                        )
                      ],
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  "Add Timetable",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
