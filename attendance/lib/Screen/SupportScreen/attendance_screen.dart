// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print, must_be_immutable

import 'dart:convert';

import 'package:attendance/Data/profile_data.dart';
import 'package:attendance/Data/state_data.dart';
import 'package:attendance/Data/student_detail.dart';
import 'package:attendance/components/student_card_attendance.dart';
import 'package:attendance/constants.dart';
import 'package:attendance/models/student.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceScreen extends StatelessWidget {
  static String id = 'attendance_screen';
  AttendanceScreen({super.key});
  int? count;
  String? subjectId;
  String? branch;
  String? section;

  List<Widget> studentList(List<Student> list, BuildContext context, var info) {
    List<Widget> data = [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Mark All Absent",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Checkbox(
                value: Provider.of<StudentDetail>(context).allMarkedTrue,
                onChanged: (val) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Mark All "),
                      content: Text(
                        "Are you sure want to mark everyone ${(Provider.of<StudentDetail>(context).allMarkedTrue) ? "present" : "absent"}",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Provider.of<StudentDetail>(context,
                                    listen: false)
                                .markAllAbsent(val);
                            if (!context.mounted) return;
                            Navigator.pop(context);
                          },
                          child: Text("Yes"),
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      )
    ];
    for (int i = 0; i < list.length; i++) {
      // print(list[i]['Name']);
      int x = list[i].scholarNumber.length;
      data.add(
        StudentCard(
          name: list[i].name,
          scholarNumber: list[i].scholarNumber,
          serialNumber: (list[i].scholarNumber.substring(x - 2, x)),
          index: i,
        ),
      );
    }
    data.add(AbsentStudent());
    data.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Attendance Count:",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: kInactiveTextColor),
        ),
        DropdownButton(
          value: Provider.of<StateData>(context).getClassCount,
          hint: Text("Set Count"),
          items: [
            DropdownMenuItem(
              value: 0,
              child: Text("0"),
            ),
            DropdownMenuItem(
              value: 1,
              child: Text("1"),
            ),
            DropdownMenuItem(
              value: 2,
              child: Text("2"),
            ),
            DropdownMenuItem(
              value: 3,
              child: Text("3"),
            ),
            DropdownMenuItem(
              value: 4,
              child: Text("4"),
            ),
          ],
          onChanged: (e) {
            Provider.of<StateData>(context, listen: false)
                .setClassCount(e ?? 1);
          },
        )
      ],
    ));
    data.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Submit Attendance'),
                content: Text('Once submitted then It cannot be edited!!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      List<Student> data =
                          Provider.of<StudentDetail>(context, listen: false)
                              .getData;
                      List<dynamic> res = [];
                      for (var item in data) {
                        res.add({
                          "Scholar No.": item.scholarNumber,
                          "Name of Student": item.name,
                          "isPresent": item.isPresent ? "1" : "0",
                        });
                      }

                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String auth = prefs.getString('authorization')!;

                      var url =
                          Uri.parse('$kBaseLink/api/attendance/setAttendance');
                      if (!context.mounted) return;
                      var employeeId =
                          Provider.of<ProfileData>(context, listen: false)
                              .employeeId;
                      // var section =
                      //     Provider.of<StudentDetail>(context, listen: false)
                      //         .sectionName;

                      var response = await http.post(
                        url,
                        headers: {
                          'Content-type': 'application/json',
                          'authorization': auth
                        },
                        body: jsonEncode(
                          {
                            "subjectId": subjectId,
                            "branch": branch,
                            "data": {
                              "date":
                                  Provider.of<StateData>(context, listen: false)
                                      .selectedDay
                                      .toString(),
                              "attendance": res,
                            },
                            "section": section,
                            "count":
                                Provider.of<StateData>(context, listen: false)
                                    .getClassCount,
                          },
                        ),
                      );
                      if (response.statusCode == 200) {
                        if (!context.mounted) return;
                        Provider.of<StateData>(context, listen: false)
                            .setClassCount(1);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Successfully saved'),
                          ),
                        );
                      } else {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Error!!',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        return;
                      }
                      if (!context.mounted) return;
                      Navigator.pop(context);
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
            "Send Attendance",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    // print(arguments);
    subjectId = arguments["data"]["subjectId"];
    branch = arguments["data"]["branch"];
    section = arguments["data"]["section"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Provider.of<StudentDetail>(context).subjectName,
          style: TextStyle(fontSize: 17),
          textAlign: TextAlign.start,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(Provider.of<StudentDetail>(context).sectionName),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: studentList(Provider.of<StudentDetail>(context).getData,
              context, arguments['data']),
        ),
      ),
    );
  }
}
//
// class StudentCard extends StatefulWidget {
//   final String name;
//   final String scholarNumber;
//   final int index;
//   final String serialNumber;
//   const StudentCard({
//     super.key,
//     required this.name,
//     required this.scholarNumber,
//     this.index = 0,
//     this.serialNumber = "00",
//   });
//
//   @override
//   State<StudentCard> createState() => _StudentCardState();
// }
//
// class _StudentCardState extends State<StudentCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             '${widget.serialNumber}.',
//             style: TextStyle(fontSize: 20),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             flex: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.name,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   widget.scholarNumber,
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Checkbox(
//               value:
//                   Provider.of<StudentDetail>(context).isPresent(widget.index),
//               onChanged: (val) {
//                 Provider.of<StudentDetail>(context, listen: false)
//                     .setIsPresent(widget.index);
//               })
//         ],
//       ),
//     );
//   }
// }

class AbsentStudent extends StatelessWidget {
  const AbsentStudent({super.key});
  String absentites(List<String> absent) {
    String s = "";
    for (String student in absent) {
      int x = student.length;
      s += student.substring(x - 2, x);
      s += " ";
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  Absent:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            absentites(Provider.of<StudentDetail>(context).absenties),
            maxLines: 4,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// class StudentCard extends StatelessWidget {
//   final String name;
//   final String scholarNumber;
//   final int index;
//   final String serialNumber;
//   const StudentCard({
//     super.key,
//     required this.name,
//     required this.scholarNumber,
//     this.index = 0,
//     this.serialNumber = "00",
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             '$serialNumber.',
//             style: TextStyle(fontSize: 20),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             flex: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   scholarNumber,
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Checkbox(
//               value: Provider.of<StudentDetail>(context).isPresent(index),
//               onChanged: (val) {
//                 Provider.of<StudentDetail>(context, listen: false)
//                     .setIsPresent(index);
//               })
//         ],
//       ),
//     );
//   }
// }
