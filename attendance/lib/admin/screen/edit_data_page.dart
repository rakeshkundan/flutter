// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:attendance/components/input_box.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditDataPage extends StatefulWidget {
  static String id = "edit_data_page";
  final String employeeCode;
  final dynamic data;
  const EditDataPage({super.key, this.employeeCode = "", this.data = ""});

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  TextEditingController employeeCode = TextEditingController();
  TextEditingController subCode = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController timing = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController course = TextEditingController();
  String semValue = "", section = "";
  @override
  void initState() {
    // TODO: implement initState

    employeeCode.text = widget.employeeCode;
    subCode.text = widget.data['subject']['subjectCode'] ?? "";
    branch.text = widget.data['branch'] ?? "";
    timing.text = widget.data['timing'] ?? "";
    location.text = widget.data['location'] ?? "";
    course.text = widget.data['course'] ?? "";
    semValue = widget.data['semester'] ?? "";
    section = widget.data['section'] ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Timetable"),
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
                onChanged: (x) {
                  setState(() {
                    semValue = x!;
                  });
                },
                value: semValue,
                items: [
                  DropdownMenuItem(
                    value: "",
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
            InputBox(
              textController: timing,
              label: "Timing (Like:12:00-1:00PM)",
            ),
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
            InputBox(
              textController: location,
              label: "Location",
            ),
            InputBox(
              textController: course,
              label: "Course (Like:B-tech)",
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
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? authorization =
                                prefs.getString('authorization');
                            var headers = {
                              "Accept": "*/*",
                              "Content-Type": "application/json"
                            };
                            headers['authorization'] = authorization!;
                            // await http.post(
                            //   Uri.parse("$kAdminPath/"),
                            //   headers: headers,
                            //   body: jsonEncode(data),
                            //   encoding: Encoding.getByName('utf-8'),
                            // )
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
                  "Modify Timetable",
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
