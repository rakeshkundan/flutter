import 'package:attendance/Data/state_data.dart';
import 'package:attendance/Data/student_detail.dart';
import 'package:attendance/Data/time_table.dart';
import 'package:attendance/Screen/SupportScreen/attendance_screen.dart';
import 'package:attendance/Screen/initial_screen.dart';
import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/components/schedule_card.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  static String id = 'schedule_screen';
  const ScheduleScreen({super.key});
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool spinner = true;
  dynamic scheduleData;
  void initialCall() async {
    setState(() {
      spinner = true;
    });
    NetworkHelper nethelp = NetworkHelper(
      url:
          "$kScheduleLink?day=${Provider.of<StateData>(context, listen: false).selectedDay.weekday}",
      head: true,
    );

    var data = await nethelp.getData();
    // print(data);
    if (data != " Network Error" && data != "unauthorized") {
      if (!mounted) return;
      await Provider.of<TimeTable>(context, listen: false).setSchedule(data);
    }
    if (data == 'unauthorized') {
      if (!mounted) return;
      Navigator.popUntil(context, (route) => false);
      Navigator.pushNamed(context, InitialScreen.id);
    }
    setState(() {
      spinner = false;
    });
  }

  List<Widget> rowBuilder(dynamic schedule) {
    List<Widget> list = [];
    //print(schedule);
    int i = 0;
    if (schedule['TimeTable'] is List) {
      for (var item in schedule['TimeTable']) {
        // print(item);
        list.add(
          ScheduleCard(
            index: i,
            data: item,
            onTap: () async {
              String date = Provider.of<StateData>(context, listen: false)
                  .focusedDay
                  .toString()
                  .split(' ')[0];
              String dateTime = '${item['timing']} $date';
              Provider.of<TimeTable>(context, listen: false)
                  .setProgressBar(true);
              String? subjectId = item['subject']['_id'];
              var isElective = item['subject']['isElective'];
              NetworkHelper nethelp = NetworkHelper(
                url:
                    '$kBaseLink/api/Student/getStudentList?branch=${item["branch"]}&section=${item["section"]}&batch=${item["session"]}&isElective=$isElective&subjectId=$subjectId&dateTime=$dateTime',
                head: true,
              );
              var data = await nethelp.getData();
              // print(data['message']);
              if (data == 'Network Error') {
                // print('Error');
              } else if (data is List) {
                if (!mounted) return;
                await Provider.of<StudentDetail>(context, listen: false)
                    .setData({
                  "subCode": item['subject']['subjectCode'],
                  "data": data,
                  "section": item['section'],
                });
                if (!mounted) return;
                Provider.of<StudentDetail>(context, listen: false).subjectName =
                    item['subject']['subjectName'];

                // print(date);
                if (!mounted) return;
                Navigator.pushNamed(
                  context,
                  AttendanceScreen.id,
                  arguments: {
                    'data': {
                      "subjectCode": item['subject']['subjectCode'],
                      'section': item['section'],
                      "branch": item['branch'],
                      "subjectId": subjectId,
                      "dateTime": dateTime,
                    }
                  },
                );
              } else if (data['message'] == "already Filled") {
                if (!mounted) return;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Alert!'),
                    content: const Text('Attendance is already submitted'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                );
              }

              if (!mounted) return;
              Provider.of<TimeTable>(context, listen: false)
                  .setProgressBar(false);
            },
            isLongpressable: true,
          ),
        );
        i++;
      }
    } else {
      throw Exception('Expected a list in schedule["TimeTable"]');
    }
    list.add(const Text(
      "Temporary Assigned",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    ));
    if (schedule['Temporary'] is List) {
      for (var item in schedule['Temporary']) {
        // print(item);
        list.add(
          ScheduleCard(
            index: i,
            data: item,
            onTap: () async {
              String date = Provider.of<StateData>(context, listen: false)
                  .focusedDay
                  .toString()
                  .split(' ')[0];
              String dateTime = '${item['timing']} $date';
              Provider.of<TimeTable>(context, listen: false)
                  .setProgressBar(true);
              String? subjectId = item['subject']['_id'];
              var isElective = item['subject']['isElective'];
              NetworkHelper nethelp = NetworkHelper(
                url:
                    '$kBaseLink/api/Student/getStudentList?branch=${item["branch"]}&section=${item["section"]}&batch=${item["session"]}&isElective=$isElective&subjectId=$subjectId&dateTime=$dateTime&temp=1',
                head: true,
              );
              var data = await nethelp.getData();
              // print(data['message']);
              if (data == 'Network Error') {
                // print('Error');
              } else if (data is List) {
                if (!mounted) return;
                await Provider.of<StudentDetail>(context, listen: false)
                    .setData({
                  "subCode": item['subject']['subjectCode'],
                  "data": data,
                  "section": item['section'],
                });
                if (!mounted) return;
                Provider.of<StudentDetail>(context, listen: false).subjectName =
                    item['subject']['subjectName'];

                // print(date);
                if (!mounted) return;
                Navigator.pushNamed(
                  context,
                  AttendanceScreen.id,
                  arguments: {
                    'data': {
                      "subjectCode": item['subject']['subjectCode'],
                      'section': item['section'],
                      "branch": item['branch'],
                      "subjectId": subjectId,
                      "dateTime": dateTime,
                    }
                  },
                );
              } else if (data['message'] == "already Filled") {
                if (!mounted) return;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Alert!'),
                    content: const Text('Attendance is already submitted'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                );
              }

              if (!mounted) return;
              Provider.of<TimeTable>(context, listen: false)
                  .setProgressBar(false);
            },
          ),
        );
        i++;
      }
    } else {
      if (kDebugMode) {
        print('Expected schedule["Temporary"] to be a list');
      }
    }

    if (list.length == 1) {
      list = [
        const SizedBox(
          height: 200,
        ),
        const Text(
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
        const SizedBox(
          height: 10,
        ),
        RawMaterialButton(
          onPressed: () async {
            initialCall();
          },
          fillColor: Colors.grey.shade700,
          constraints: const BoxConstraints(minWidth: 10),
          padding: const EdgeInsets.all(7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
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
    super.initState();
    initialCall();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Schedule',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: SingleChildScrollView(
                            child: Container(
                                color: Colors.white,
                                child: Material(
                                  child: TableCalendar(
                                    onFormatChanged: (e) {
                                      // print(e);
                                    },
                                    focusedDay: Provider.of<StateData>(context)
                                        .selected,
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    selectedDayPredicate: (day) {
                                      return isSameDay(
                                          Provider.of<StateData>(context)
                                              .selected,
                                          day);
                                    },
                                    onDaySelected:
                                        (selectedDay, focusedDay) async {
                                      setState(() {
                                        spinner = true;
                                      });
                                      Provider.of<TimeTable>(context,
                                              listen: false)
                                          .setProgressBar(true);
                                      await Provider.of<StateData>(context,
                                              listen: false)
                                          .setDay(selectedDay, focusedDay);

                                      NetworkHelper nethelp = NetworkHelper(
                                        url:
                                            '$kScheduleLink?day=${selectedDay.weekday}',
                                        head: true,
                                      );
                                      var data = await nethelp.getData();

                                      if (data != "unauthorized") {
                                        if (!context.mounted) return;
                                        Provider.of<TimeTable>(context,
                                                listen: false)
                                            .setSchedule(data);
                                      } else {
                                        initialCall();
                                      }
                                      if (!context.mounted) return;
                                      Provider.of<TimeTable>(context,
                                              listen: false)
                                          .setProgressBar(false);
                                      setState(() {
                                        spinner = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                )),
                          ),
                        ),
                      );
                    },
                    constraints: const BoxConstraints(
                      minWidth: 0,
                    ),
                    child: const Icon(Icons.calendar_month),
                  )
                ],
              ),
            ),
          ),
          // TableCalendar(
          //   headerVisible: false,
          //   calendarFormat: CalendarFormat.week,
          //   focusedDay: Provider.of<StateData>(context).selected,
          //   firstDay: DateTime.utc(2010, 10, 16),
          //   lastDay: DateTime.utc(2030, 3, 14),
          //   selectedDayPredicate: (day) {
          //     return isSameDay(Provider.of<StateData>(context).selected, day);
          //   },
          //   onDaySelected: (selectedDay, focusedDay) async {
          //     Provider.of<TimeTable>(context, listen: false)
          //         .setProgressBar(true);
          //     await Provider.of<StateData>(context, listen: false)
          //         .setDay(selectedDay, focusedDay);
          //     // print('$selectedDay $focusedDay');
          //     // await Future.delayed(Duration(seconds: 3));
          //     // if (!mounted) return;
          //     // Navigator.pop(context);
          //     // Navigator.pushNamed(context, ScheduleScreen.id);
          //
          //     // if (!mounted) return;
          //     // Navigator.popAndPushNamed(context, ScheduleScreen.id);
          //     NetworkHelper nethelp = NetworkHelper(
          //       url: '$kScheduleLink?day=${selectedDay.weekday}',
          //       head: true,
          //     );
          //     var data = await nethelp.getData();
          //     if (!mounted) return;
          //     if (data != "unauthorized") {
          //       Provider.of<TimeTable>(context, listen: false)
          //           .setSchedule(data);
          //     } else {
          //       initialCall();
          //     }
          //     if (!context.mounted) return;
          //     Provider.of<TimeTable>(context, listen: false)
          //         .setProgressBar(false);
          //     // print(data);
          //     // scheduleData = data;
          //   },
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Date:${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kInactiveTextColor,
                ),
              ),
              Text(
                'Selected Date:${Provider.of<StateData>(context).selected.day}/${Provider.of<StateData>(context).selected.month}/${Provider.of<StateData>(context).selected.year}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kInactiveTextColor,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 7,
            child: ModalProgressHUD(
              inAsyncCall: Provider.of<TimeTable>(context).isProgress,
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2), () {});
                  if (!context.mounted) return;
                  Navigator.popAndPushNamed(context, InitialScreen.id);
                },
                child: !spinner
                    ? SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: Provider.of<TimeTable>(context)
                                        .scheduleData ==
                                    "Network Error"
                                ? [
                                    const SizedBox(
                                      height: 200,
                                    ),
                                    const Text(
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RawMaterialButton(
                                      onPressed: () async {
                                        initialCall();
                                      },
                                      fillColor: Colors.grey.shade700,
                                      constraints:
                                          const BoxConstraints(minWidth: 10),
                                      padding: const EdgeInsets.all(7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
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
                                    Provider.of<TimeTable>(context)
                                        .scheduleData,
                                  ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: kInactiveTextColor,
                              child: const ShemmerCard(),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: kInactiveTextColor,
                              child: const ShemmerCard(),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: kInactiveTextColor,
                              child: const ShemmerCard(),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: kInactiveTextColor,
                              child: const ShemmerCard(),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShemmerCard extends StatelessWidget {
  const ShemmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                width: 100,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                width: 280,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
