// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:attendance/Data/student_detail.dart';
import 'package:attendance/Screen/SupportScreen/student_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendancePercentageList extends StatefulWidget {
  static String id = 'attendance_percentage_list';
  const AttendancePercentageList({super.key});

  @override
  State<AttendancePercentageList> createState() =>
      _AttendancePercentageListState();
}

class _AttendancePercentageListState extends State<AttendancePercentageList> {
  dynamic arguments;
  List<StudentCard> list = [];
  void listMaker(arguments) {
    // List<StudentCard> list = [];
    // print(arguments['data'][0].key);
    for (int i = 0; i < arguments['data'].length; i++) {
      // print(arguments['data'][i].value['name']);
      list.add(
        StudentCard(
          name: arguments['data'][i].value['name'],
          // scholarNumber: arguments['data'][i].key,
          scholarNumber: arguments['data'][i].key,
          serialNumber: (i + 1).toString(),
        ),
      );
    }
    setState(() {
      list;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      listMaker(arguments);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: list),
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final String name;
  final String scholarNumber;
  final int index;
  final String serialNumber;
  const StudentCard({
    super.key,
    required this.name,
    required this.scholarNumber,
    this.index = 0,
    this.serialNumber = "00",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                StudentSummaryScreen(scholarNumber: scholarNumber)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$serialNumber.',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    scholarNumber,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
