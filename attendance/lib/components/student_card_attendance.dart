import 'package:attendance/Data/student_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Checkbox(
              value: Provider.of<StudentDetail>(context).isPresent(index),
              onChanged: (val) {
                Provider.of<StudentDetail>(context, listen: false)
                    .setIsPresent(index);
              })
        ],
      ),
    );
  }
}
