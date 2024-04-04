// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:attendance/Data/student_detail.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            StudentCard(
              name: "Rakesh kundan",
              scholarNumber: "211112001",
              serialNumber: "01",
            ),
            StudentCard(
              name: "Rakesh kundan",
              scholarNumber: "211112002",
              serialNumber: "02",
            ),
            StudentCard(
              name: "Rakesh kundan",
              scholarNumber: "211112011",
              serialNumber: "03",
            ),
            StudentCard(
              name: "Rakesh kundan",
              scholarNumber: "211112011",
              serialNumber: "04",
            ),
          ],
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
