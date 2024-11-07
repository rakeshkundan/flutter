// ignore_for_file: prefer_const_constructors

import 'package:attendance/Screen/SupportScreen/replace_faculty.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatefulWidget {
  final dynamic data;
  final VoidCallback onTap;
  final int index;
  const ScheduleCard(
      {super.key, required this.data, required this.onTap, this.index = 0});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        setState(() {
          selected = true;
        });
        await showMenu(
          position: RelativeRect.fromLTRB(0, 0, 0, 0),
          items: <PopupMenuEntry>[
            PopupMenuItem(
              value: widget.index,
              child: Row(
                children: const <Widget>[
                  Icon(Icons.person_add),
                  Text("Replacement"),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Replacement(data: widget.data)));
              },
            )
          ],
          context: context,
        );
        setState(() {
          selected = false;
        });
      },
      onTap: widget.onTap,
      child: Container(
        // color: Colors.lightBlue,
        decoration: BoxDecoration(
            color: selected
                ? kInactiveTextColor.withOpacity(.2)
                : Colors.transparent,
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.data['branch']}${widget.data['section']}(${widget.data['semester']})',
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${widget.data['subject']['subjectName']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      // color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${widget.data['timing']} (${widget.data['location']})',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(),
                ),
              ],
            ),
            // data['done']
            //     ? CircleAvatar(
            //         backgroundColor: Colors.green,
            //         foregroundColor: Colors.white,
            //         radius: 17.0,
            //         child: Icon(
            //           Icons.check,
            //           weight: 50,
            //         ),
            //       )
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}
