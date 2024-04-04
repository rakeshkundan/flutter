// ignore_for_file: prefer_const_constructors

import 'package:attendance/Utilities/file_storage.dart';
import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

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
    // TODO: implement initState
    listSetter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download Attendance"),
      ),
      body: spinner
          ? Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: kInactiveTextColor,
              child: ShemmerCard(),
            )
          : SafeArea(
              child: ModalProgressHUD(
                opacity: 1,
                color: Colors.white,
                progressIndicator: const SpinKitFadingCircle(
                  color: kInactiveTextColor,
                  size: 80,
                ),
                inAsyncCall: spinner,
                child: Column(
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
                        if (session != null &&
                            session != '0' &&
                            branch != null &&
                            branch != "0" &&
                            section != null &&
                            section != '0' &&
                            subject != null &&
                            subject != '0') {
                          await FileStorage.writeCounter(
                            data: {
                              "session": session,
                              "branch": branch,
                              "section": section,
                              "subject": subject
                            },
                            progressIndicator: (current, total) {
                              final progress = (current / total) * 100;
                              // print('Downloading: $progress');
                              CircularPercentIndicator(
                                radius: 60.0,
                                lineWidth: 5.0,
                                percent: progress / 100,
                                center: Text("$progress"),
                                progressColor: Colors.green,
                              );
                            },
                            onDone: () {
                              // OpenFile.open("$path/Cse01.xlsx");
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Download Status!'),
                                  content: Text('Downloaded Successfully!!'),
                                  actions: [
                                    // TextButton(
                                    //   onPressed: () {
                                    //     Navigator.pop(context);
                                    //   },
                                    //   child: Text('Cancel'),
                                    // ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok'),
                                    )
                                  ],
                                ),
                              );
                              // print('Download done');
                              // OpenFile.open("$localpath/Cse01.xlsx");
                            },
                          );
                          // if (!context.mounted) return;
                          // Navigator.pop(context);
                        } else {
                          // print("Check field");
                        }
                      },
                      elevation: 5,
                      constraints:
                          const BoxConstraints(minWidth: 150, minHeight: 43),
                      fillColor: kInactiveTextColor,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
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
