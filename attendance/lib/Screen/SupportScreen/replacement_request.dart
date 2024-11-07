// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/components/schedule_card.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReplacementRequest extends StatefulWidget {
  static String id = "replacement_request";
  const ReplacementRequest({super.key});

  @override
  State<ReplacementRequest> createState() => _ReplacementRequestState();
}

class _ReplacementRequestState extends State<ReplacementRequest> {
  bool isFetching = true;
  List<Widget> list = [];
  void columnBuilder(BuildContext context) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String auth = prefs.getString('authorization') ?? "";
    String url = "$kBaseLink/api/timetable/requestList";
    NetworkHelper netHelp = NetworkHelper(url: url, head: true);
    var data = await netHelp.getData();
    // print(data);
    for (var item in data['list']) {
      list.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xD3D3D3D3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Requested By:${item["from"]["name"]}"),
            Card(data: item['timetable']),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RawMaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    setState(() {
                      isFetching = true;
                    });
                    var data = {"id": item['id']};
                    // print(data);
                    String url = "$kBaseLink/api/timetable/acceptRequest";
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String auth = prefs.getString('authorization') ?? "";
                    var response = await http.post(
                      Uri.parse(url),
                      headers: {
                        "Accept": "*/*",
                        "Content-Type": "application/json",
                        "authorization": auth
                      },
                      body: jsonEncode(data),
                      encoding: Encoding.getByName('utf-8'),
                    );
                    var resp = jsonDecode(response.body);
                    print(resp);
                    setState(() {
                      isFetching = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 7.0),
                    child: Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                RawMaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    setState(() {
                      isFetching = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 7.0),
                    child: Text(
                      'Reject',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ));
    }
    isFetching = false;
    setState(() {});
  }

  @override
  void initState() {
    columnBuilder(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isFetching,
          child: Column(
            children: list,
          ),
        ),
      ),
    );
  }
}

class Card extends StatefulWidget {
  final dynamic data;

  final int index;
  const Card({super.key, required this.data, this.index = 0});

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
