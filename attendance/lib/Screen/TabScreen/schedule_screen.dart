// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:attendance/Data/profile_data.dart';
import 'package:attendance/Data/state_data.dart';
import 'package:attendance/Data/student_detail.dart';
import 'package:attendance/Data/time_table.dart';
import 'package:attendance/Screen/attendance_screen.dart';
import 'package:attendance/Screen/home.dart';
import 'package:attendance/Screen/initial_screen.dart';
import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  static String id = 'schedule_screen';
  const ScheduleScreen({super.key});
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  dynamic scheduleData;
  List<Widget> rowBuilder(dynamic schedule) {
    List<Widget> list = [];
    // print(schedule);
    int i = 0;
    for (var item in schedule) {
      // print(item);
      list.add(
        ScheduleCard(
          index: i,
          data: item,
          onTap: () async {
            Provider.of<TimeTable>(context, listen: false).setProgressBar(true);
            NetworkHelper nethelp = NetworkHelper(
              url:
                  '$kBaseLink/api/class/getClassList?sec=${item['branch']}${item['section']}',
              head: true,
            );
            var data = await nethelp.getData();
            // print(data);
            if (data == 'Network Error') {
              print('Error');
            } else {
              if (!context.mounted) return;
              await Provider.of<StudentDetail>(context, listen: false)
                  .setData(data);
              if (!context.mounted) return;
              Provider.of<StudentDetail>(context, listen: false).subjectName =
                  item['subject']['subjectName'];
              if (!context.mounted) return;
              Navigator.pushNamed(
                context,
                AttendanceScreen.id,
                arguments: {
                  'data': {
                    "subjectCode": item['subject']['subjectCode'],
                    'section': item['section'],
                    "branch": item['branch']
                  }
                },
              );
            }
            if (!context.mounted) return;
            Provider.of<TimeTable>(context, listen: false)
                .setProgressBar(false);
          },
        ),
      );
      i++;
    }

    if (list.isEmpty) {
      list = [
        SizedBox(
          height: 200,
        ),
        Text(
          'No Classes!!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
        ),
        Text(
          'If Any error then Contact Admin',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        RawMaterialButton(
          onPressed: () async {
            Navigator.popAndPushNamed(context, Home.id);
          },
          fillColor: Colors.grey.shade700,
          constraints: BoxConstraints(minWidth: 10),
          padding: EdgeInsets.all(7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            'Refresh',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ];
    }
    return list;
  }

  @override
  void initState() {
    // NetworkHelper nethelp = NetworkHelper(
    //   url:
    //       "$kScheduleLink?day=${Provider.of<StateData>(context, listen: false).selectedDay.weekday}",
    //   head: true,
    // );
    //
    // scheduleData = nethelp.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: SpinKitFadingCircle(
        color: Colors.blue,
        size: 80,
      ),
      inAsyncCall: Provider.of<TimeTable>(context).isProgress,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Schedule',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (context) => Center(
                        //     child: SingleChildScrollView(
                        //       child: Container(
                        //         color: Colors.white,
                        //         child: TableCalendar(
                        //           firstDay: DateTime.utc(2010, 10, 16),
                        //           lastDay: DateTime.utc(2030, 3, 14),
                        //           focusedDay: DateTime.now(),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                      constraints: BoxConstraints(
                        minWidth: 0,
                      ),
                      child: Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
            ),
            TableCalendar(
              headerVisible: false,
              calendarFormat: CalendarFormat.week,
              focusedDay: Provider.of<StateData>(context).selected,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              selectedDayPredicate: (day) {
                return isSameDay(Provider.of<StateData>(context).selected, day);
              },
              onDaySelected: (selectedDay, focusedDay) async {
                Provider.of<TimeTable>(context, listen: false)
                    .setProgressBar(true);
                await Provider.of<StateData>(context, listen: false)
                    .setDay(selectedDay, focusedDay);
                // await Future.delayed(Duration(seconds: 3));
                // if (!mounted) return;
                // Navigator.pop(context);
                // Navigator.pushNamed(context, ScheduleScreen.id);

                // if (!mounted) return;
                // Navigator.popAndPushNamed(context, ScheduleScreen.id);
                NetworkHelper nethelp = NetworkHelper(
                  url: '$kScheduleLink?day=${selectedDay.weekday}',
                  head: true,
                );
                var data = await nethelp.getData();
                if (!mounted) return;
                Provider.of<TimeTable>(context, listen: false)
                    .setSchedule(data);
                Provider.of<TimeTable>(context, listen: false)
                    .setProgressBar(false);
                // print(data);
                // scheduleData = data;
              },
            ),
            Expanded(
              flex: 7,
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2), () {});
                  if (!mounted) return;
                  Navigator.popAndPushNamed(context, InitialScreen.id);
                },
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: Provider.of<TimeTable>(context).scheduleData ==
                              "Network Error"
                          ? [
                              SizedBox(
                                height: 200,
                              ),
                              Text(
                                'Network Error!!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                'If Any error then Contact Admin',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RawMaterialButton(
                                onPressed: () async {
                                  Provider.of<TimeTable>(context, listen: false)
                                      .setProgressBar(true);
                                  NetworkHelper nethelp = NetworkHelper(
                                      url:
                                          '$kScheduleLink?d=${Provider.of<StateData>(context, listen: false).selected.weekday}&employeeId=${Provider.of<ProfileData>(context, listen: false).employeeId}');
                                  var data = await nethelp.getData();
                                  if (!mounted) return;
                                  Provider.of<TimeTable>(context, listen: false)
                                      .setSchedule(data);
                                  Provider.of<TimeTable>(context, listen: false)
                                      .setProgressBar(false);
                                },
                                fillColor: Colors.grey.shade700,
                                constraints: BoxConstraints(minWidth: 10),
                                padding: EdgeInsets.all(7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Refresh',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ]
                          : rowBuilder(
                              Provider.of<TimeTable>(context).scheduleData),
                    ),
                  ),
                  // child: FutureBuilder(
                  //   future: Provider.of<TimeTable>(context).scheduleData,
                  //   builder: (context, AsyncSnapshot<dynamic> snapShot) {
                  //     if (snapShot.hasData) {
                  //       var data = snapShot.data;
                  //       // print(data);
                  //       if (data != 'Network Error') {
                  //         return SingleChildScrollView(
                  //           physics: AlwaysScrollableScrollPhysics(),
                  //           scrollDirection: Axis.vertical,
                  //           child: Column(
                  //             children: snapShot.data.length == 0
                  //                 ? [
                  //                     SizedBox(
                  //                       height: 200,
                  //                     ),
                  //                     Text(
                  //                       'No Classes!!',
                  //                       textAlign: TextAlign.center,
                  //                       style: TextStyle(
                  //                         fontSize: 27,
                  //                         fontWeight: FontWeight.w700,
                  //                         color: Colors.red,
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       'If Any error then Contact Admin',
                  //                       textAlign: TextAlign.center,
                  //                       style: TextStyle(
                  //                         color: Colors.grey.shade700,
                  //                         fontSize: 15,
                  //                         fontWeight: FontWeight.w500,
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 10,
                  //                     ),
                  //                     RawMaterialButton(
                  //                       onPressed: () async {},
                  //                       fillColor: Colors.grey.shade700,
                  //                       constraints:
                  //                           BoxConstraints(minWidth: 10),
                  //                       padding: EdgeInsets.all(7),
                  //                       shape: RoundedRectangleBorder(
                  //                         borderRadius:
                  //                             BorderRadius.circular(5),
                  //                       ),
                  //                       child: Text(
                  //                         'Refresh',
                  //                         style: TextStyle(
                  //                           fontSize: 20,
                  //                           fontWeight: FontWeight.w600,
                  //                           color: Colors.white,
                  //                         ),
                  //                       ),
                  //                     )
                  //                   ]
                  //                 : rowBuilder(snapShot.data),
                  //           ),
                  //         );
                  //       } else {
                  //         return SingleChildScrollView(
                  //           physics: AlwaysScrollableScrollPhysics(),
                  //           child: Column(
                  //             // crossAxisAlignment: CrossAxisAlignment.stretch,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               SizedBox(
                  //                 height: 200,
                  //               ),
                  //               Text(
                  //                 'Network Error!!',
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                   fontSize: 27,
                  //                   fontWeight: FontWeight.w700,
                  //                   color: Colors.red,
                  //                 ),
                  //               ),
                  //               Text(
                  //                 'Please Connect Internet and Refresh.',
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                   color: Colors.grey.shade700,
                  //                   fontSize: 15,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               RawMaterialButton(
                  //                 onPressed: () async {
                  //                   // Provider.of<TimeTable>(context,
                  //                   //         listen: false)
                  //                   //     .setProgressBar(true);
                  //                   // await Future.delayed(
                  //                   //   Duration(seconds: 3),
                  //                   // );
                  //                   // if (!mounted) return;
                  //                   // Provider.of<TimeTable>(context,
                  //                   //         listen: false)
                  //                   //     .setProgressBar(false);
                  //                   // Navigator.popAndPushNamed(
                  //                   //     context, InitialScreen.id);
                  //                 },
                  //                 fillColor: Colors.grey.shade700,
                  //                 constraints: BoxConstraints(minWidth: 10),
                  //                 padding: EdgeInsets.all(7),
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(5),
                  //                 ),
                  //                 child: Text(
                  //                   'Refresh',
                  //                   style: TextStyle(
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.w600,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         );
                  //       }
                  //     } else if (snapShot.hasError) {
                  //       // print(snapShot.error);
                  //       return Text('Network Error!!');
                  //     }
                  //     return SpinKitFadingFour(
                  //       color: Colors.blue,
                  //     );
                  //   },
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final dynamic data;
  final VoidCallback onTap;
  final int index;
  const ScheduleCard(
      {super.key, required this.data, required this.onTap, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onLongPress: () {
      //   showMenu(
      //     position: RelativeRect.fromLTRB(0, 0, 0, 0),
      //     items: <PopupMenuEntry>[
      //       PopupMenuItem(
      //         value: index,
      //         child: Row(
      //           children: <Widget>[
      //             Icon(Icons.delete),
      //             Text("Delete"),
      //           ],
      //         ),
      //       )
      //     ],
      //     context: context,
      //   );
      // },
      onTap: onTap,
      child: Container(
        // color: Colors.lightBlue,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data['branch']}${data['section']}(${data['semester']})',
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${data['subject']['subjectName']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${data['timing']} (${data['location']})',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(),
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

// class ScheduleScreen extends StatelessWidget {
//   static String id = 'schedule_screen';
//   ScheduleScreen({super.key});
//   final NetworkHelper nethelp=NetworkHelper(url: 'http://localhost:3000/timeTable');
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Schedule',
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 RawMaterialButton(
//                   onPressed: () {},
//                   constraints: BoxConstraints(
//                     minWidth: 0,
//                   ),
//                   child: Icon(Icons.calendar_month),
//                 )
//               ],
//             ),
//           ),
//           SingleChildScrollView(
//             child: Column(
//               children:
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
