// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:attendance/Utilities/file_storage.dart';
import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AttendanceDownloadScreen extends StatefulWidget {
  static String id = "attendance_download_screen";
  const AttendanceDownloadScreen({super.key});

  @override
  State<AttendanceDownloadScreen> createState() =>
      _AttendanceDownloadScreenState();
}

class _AttendanceDownloadScreenState extends State<AttendanceDownloadScreen> {
  bool spinner = true;
  String? session;
  String? branch;
  String? section;
  String? subject;
  late List<DropdownMenuItem<String>> branchList = [
        DropdownMenuItem(
          value: "0",
          child: Text("Select Branch"),
        )
      ],
      sectionList = [
        DropdownMenuItem(
          value: "0",
          child: Text("Select Section"),
        )
      ],
      subjectList = [
        DropdownMenuItem(
          value: "0",
          child: Text("Select Subject"),
        )
      ],
      sessionList = [
        DropdownMenuItem(
          value: "0",
          child: Text("Select Session"),
        )
      ];

  void listSetter() async {
    NetworkHelper nethelp = NetworkHelper(
      url: "$kBaseLink/api/attendance/dashboardHelper",
      head: true,
    );

    var data = await nethelp.getData();
    // print(data);
    for (var item in data['data']['branch']) {
      // print(item);
      branchList.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    }
    for (var item in data['data']['section']) {
      sectionList.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    }
    for (var item in data['data']['subject']) {
      subjectList.add(
        DropdownMenuItem(
          value: item['_id'],
          child: Text(
            item['subjectName'],
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    for (var item in data['data']['session']) {
      sessionList.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    }
    setState(() {
      spinner = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    listSetter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Attendance"),
      ),
      body: SafeArea(
        child: spinner
            ? SpinKitFadingCircle(
                color: kInactiveTextColor,
                size: 90,
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton(
                        value: branch,
                        hint: Text("Select Branch"),
                        items: branchList,
                        onChanged: (e) {
                          setState(() {
                            branch = e;
                          });
                        },
                      ),
                      DropdownButton(
                        value: section,
                        hint: Text("Select Section"),
                        items: sectionList,
                        onChanged: (e) {
                          setState(() {
                            section = e;
                          });
                        },
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  DropdownButton(
                    hint: Text("Select Subject"),
                    value: subject,
                    items: subjectList,
                    onChanged: (e) {
                      setState(() {
                        subject = e;
                      });
                    },
                  ),
                  DropdownButton(
                    value: session,
                    hint: Text("Select Session"),
                    items: sessionList,
                    onChanged: (e) {
                      setState(() {
                        session = e;
                      });
                    },
                  ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  RawMaterialButton(
                    onPressed: () async {
                      if (session != null &&
                          session != '0' &&
                          branch != null &&
                          branch != "0" &&
                          section != null &&
                          section != '0' &&
                          subject != null &&
                          subject != '0') {
                        await FileStorage.writeCounter({
                          "session": session,
                          "branch": branch,
                          "section": section,
                          "subject": subject
                        });
                        if (!mounted) return;
                        Navigator.pop(context);
                      } else {
                        print("Check field");
                      }
                      // print("HElloo");
                      // NetworkHelper nethelp = NetworkHelper(
                      //   url: "http://localhost:3000/api/attendance/analysis",
                      //   head: true,
                      // );
                      // print(
                      //   await nethelp.postData({
                      //     "year": year,
                      //     "branch": branch,
                      //     "section": section,
                      //     "subject": subject
                      //   }),
                      // );
                    },
                    elevation: 5,
                    constraints: BoxConstraints(minWidth: 150, minHeight: 43),
                    fillColor: kInactiveTextColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Download",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

// class AttendanceDownloadScreen extends StatelessWidget {
//   static String id = "attendance_download_screen";
//   const AttendanceDownloadScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Download Attendance"),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 DropdownButton(
//                   hint: Text("Select Branch"),
//                   items: [
//                     DropdownMenuItem(
//                       value: 0,
//                       child: Text("CSE"),
//                     ),
//                   ],
//                   onChanged: (e) {
//                     print(e);
//                   },
//                 ),
//                 DropdownButton(
//                   hint: Text("Select Year"),
//                   value: 1,
//                   items: [
//                     DropdownMenuItem(
//                       value: 1,
//                       child: Text("I"),
//                     ),
//                     DropdownMenuItem(
//                       value: 2,
//                       child: Text("II"),
//                     ),
//                     DropdownMenuItem(
//                       value: 3,
//                       child: Text("III"),
//                     ),
//                     DropdownMenuItem(
//                       value: 4,
//                       child: Text("IV"),
//                     ),
//                   ],
//                   onChanged: (e) {
//                     print(e);
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
