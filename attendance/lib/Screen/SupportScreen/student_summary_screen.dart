// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentSummaryScreen extends StatefulWidget {
  static String id = "student_summary_screen";
  final String scholarNumber;
  const StudentSummaryScreen({super.key, this.scholarNumber = ""});

  @override
  State<StudentSummaryScreen> createState() => _StudentSummaryScreenState();
}

class _StudentSummaryScreenState extends State<StudentSummaryScreen> {
  dynamic summary;
  String studentName = "";
  bool spinner = true;
  List<DataRow> rowList = [];
  Future<void> summaryMaker() async {
    // NetworkHelper nethelp = NetworkHelper(
    //     url: "$kBaseLink/api/attendance/attendanceByScholarId", head: true);
    Map<String, String> headers = {
      "Accept": "*/*",
      "Content-Type": "application/json"
    };
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authorization = prefs.getString('authorization');
    headers['authorization'] = authorization!;

    http.Response response = await http.post(
      Uri.parse("$kBaseLink/api/attendance/attendanceByScholarId"),
      headers: headers,
      body: jsonEncode({"scholarNumber": widget.scholarNumber}),
      encoding: Encoding.getByName('utf-8'),
    );
    // Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      String data = response.body;
      // print(jsonDecode(data));
      setState(() {
        summary = jsonDecode(data);
        studentName = summary['studentName'];
        spinner = false;
      });
      rowBuilder(summary["summary"]);
    }

    // print(summary);
  }

  void rowBuilder(data) {
    for (var item in data) {
      int present = item["present"] ?? 1;
      int total = item["total"] ?? 1;
      int percent = (present * 100 / total).round();
      rowList.add(DataRow(
        cells: [
          DataCell(Text(
            item['subName'],
            textAlign: TextAlign.center,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          )),
          DataCell(Text(
            '${item["present"]}',
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            '${item["total"]}',
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            '$percent',
            textAlign: TextAlign.center,
          )),
        ],
      ));
    }
    setState(() {
      rowList[0];
    });
  }

  @override
  void initState() {
    summaryMaker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Summary",
          style: TextStyle(color: kInactiveTextColor),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Name:$studentName",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kInactiveTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Scholar No:${widget.scholarNumber}",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kInactiveTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 10,
                    columns: [
                      DataColumn(
                        label: Text('SubjectName'),
                      ),
                      DataColumn(
                        label: Text('Present'),
                      ),
                      DataColumn(
                        label: Text('Total'),
                      ),
                      DataColumn(
                        label: Text('Percentage'),
                      ),
                    ],
                    rows: rowList,
                    // rows: [
                    //   DataRow(
                    //     cells: [
                    //       DataCell(Text('1')),
                    //       DataCell(Text('Arshik')),
                    //       DataCell(Text('5644645')),
                    //       DataCell(Text('3')),
                    //     ],
                    //   )
                    // ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class StudentSummaryScreen extends StatelessWidget {
//   static String id = "student_summary_screen";
//   final String scholarNumber;
//   const StudentSummaryScreen({super.key, this.scholarNumber = ""});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Summary"),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Text("Scholar No:$scholarNumber"),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
