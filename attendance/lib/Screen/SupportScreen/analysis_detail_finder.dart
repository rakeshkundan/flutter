// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:attendance/Screen/SupportScreen/analysis_screen.dart';
// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class AnalysisDetailFinderScreen extends StatefulWidget {
  static String id = "attendance_detail_finder_screen";
  const AnalysisDetailFinderScreen({super.key});

  @override
  State<AnalysisDetailFinderScreen> createState() =>
      _AnalysisDetailFinderScreen();
}

class _AnalysisDetailFinderScreen extends State<AnalysisDetailFinderScreen> {
  bool spinner = true;
  String? session;
  String? branch;
  String? section;
  String? subject;
  late List<DropdownMenuItem<String>> branchList = [
        const DropdownMenuItem(
          value: "0",
          child: Text("Select Branch"),
        )
      ],
      sectionList = [
        const DropdownMenuItem(
          value: "0",
          child: Text("Select Section"),
        )
      ],
      subjectList = [
        const DropdownMenuItem(
          value: "0",
          child: Text("Select Subject"),
        )
      ],
      sessionList = [
        const DropdownMenuItem(
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
    listSetter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analyse Attendance"),
      ),
      body: spinner
          ? Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: kInactiveTextColor,
              child: ShemmerCard(),
            )
          : SafeArea(
              child: spinner
                  ? const SpinKitFadingCircle(
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
                              hint: const Text("Select Branch"),
                              items: branchList,
                              onChanged: (e) {
                                setState(() {
                                  branch = e;
                                });
                              },
                            ),
                            DropdownButton(
                              value: section,
                              hint: const Text("Select Section"),
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
                          hint: const Text("Select Subject"),
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
                          hint: const Text("Select Session"),
                          items: sessionList,
                          onChanged: (e) {
                            setState(() {
                              session = e;
                            });
                          },
                        ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        RawMaterialButton(
                          onPressed: () async {
                            setState(() {
                              spinner = true;
                            });
                            if (session != null &&
                                session != '0' &&
                                branch != null &&
                                branch != "0" &&
                                section != null &&
                                section != '0' &&
                                subject != null &&
                                subject != '0') {
                              // await FileStorage.writeCounter({
                              //   "session": session,
                              //   "branch": branch,
                              //   "section": section,
                              //   "subject": subject
                              // });
                              // NetworkHelper nethelp = NetworkHelper(
                              //   url: "http://localhost:3000/api/attendance/analysis",
                              //   head: true,
                              // );
                              //
                              // var data = await nethelp.postData({
                              //   "session": session,
                              //   "branch": branch,
                              //   "section": section,
                              //   "subject": subject
                              // });

                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? authorization =
                                  prefs.getString('authorization') ?? "";
                              var response = await http.post(
                                Uri.parse('$kBaseLink/api/attendance/analysis'),
                                headers: {
                                  "Accept": "*/*",
                                  "Content-Type": "application/json",
                                  'authorization': authorization,
                                },
                                body: jsonEncode({
                                  "session": session,
                                  "branch": branch,
                                  "section": section,
                                  "subjectId": subject
                                }),
                                encoding: Encoding.getByName('utf-8'),
                              );

                              var data = jsonDecode(response.body);
                              // print(data);
                              if (!context.mounted) return;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AnalysisScreen(
                                        branch: branch ?? "",
                                        section: section ?? "",
                                        batch: session ?? "",
                                        data: data,
                                      )));
                              // Navigator.pushNamed(
                              //   context,
                              //   AnalysisScreen.id,
                              //   arguments: {"data": data},
                              // );
                              setState(() {
                                spinner = false;
                              });
                            } else {
                              setState(() {
                                spinner = false;
                              });
                              // print("Check field");
                            }
                          },
                          elevation: 5,
                          constraints: const BoxConstraints(
                              minWidth: 150, minHeight: 43),
                          fillColor: kInactiveTextColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Analyse",
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

class ShemmerCard extends StatelessWidget {
  const ShemmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 140,
                height: 30,
                decoration: BoxDecoration(
                    color: kInactiveTextColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
              Container(
                width: 140,
                height: 30,
                decoration: BoxDecoration(
                    color: kInactiveTextColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 240,
            height: 30,
            decoration: BoxDecoration(
                color: kInactiveTextColor,
                borderRadius: BorderRadius.circular(5)),
          ),
          Container(
            width: 200,
            height: 30,
            decoration: BoxDecoration(
                color: kInactiveTextColor,
                borderRadius: BorderRadius.circular(5)),
          ),
          //   ],
          // ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 140,
            height: 45,
            decoration: BoxDecoration(
                color: kInactiveTextColor,
                borderRadius: BorderRadius.circular(5)),
          ),
        ],
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
