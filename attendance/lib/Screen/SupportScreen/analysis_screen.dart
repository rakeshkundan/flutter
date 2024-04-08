// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:attendance/Screen/SupportScreen/attendance_percentage_list.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisScreen extends StatefulWidget {
  static String id = "analysis_screen";
  final String section;
  final String batch;
  final String branch;
  dynamic data;

  AnalysisScreen(
      {super.key,
      this.branch = "CSE",
      this.batch = "Batch 25",
      this.section = "01",
      this.data});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int? totalCount;

  late dynamic arguments;
  List<dynamic> total = [];
  List<dynamic> above75 = [];
  List<dynamic> below75 = [];
  List<dynamic> above60below75 = [];
  List<dynamic> below60 = [];
  List<dynamic> special = [];
  int totalStudent = 1,
      above75Student = 1,
      above60below75Student = 1,
      below60Student = 1;

  void calculateAttendance(data) {
    // print(data);
    int count = 0;
    if (data != null) {
      totalCount = data['total'];
      // print(data['cumulativeAttendance'][0].value);
      // print(data['cumulativeAttendance']);
      for (var item in data['cumulativeAttendance'].entries) {
        var percent = item.value['isPresent'] / totalCount;
        total.add(item);
        // print(percent);

        if (percent >= 0.75) {
          above75.add(item);
        } else if (percent < .75 && percent >= .60) {
          above60below75.add(item);
          below75.add(item);
        } else {
          below75.add(item);
          below60.add(item);
        }
      }
      // print(below75.length);
      // print(total);
      setState(() {
        totalStudent = total.length;
        above75Student = above75.length;
        above60below75Student = above60below75.length;
        below60Student = below60.length;
      });
      // print(above75Student);
    }
  }

  @override
  void initState() {
    arguments = widget.data;
    calculateAttendance(arguments);

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   // arguments = (ModalRoute.of(context)?.settings.arguments ??
    //   //     <String, dynamic>{}) as Map;
    //   calculateAttendance(arguments);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(arguments);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextWidget(
                text: "Batch ${widget.batch}",
              ),
              TextWidget(
                text: widget.branch,
              ),
              TextWidget(
                text: "Section ${widget.section}",
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .5,
                child: SfCircularChart(
                  onSelectionChanged: (e) {
                    // print(e);
                  },
                  palette: const [
                    Colors.green,
                    Colors.yellow,
                    Colors.red,
                    Colors.lightGreen
                  ],
                  title: const ChartTitle(text: 'Class Analysis'),
                  legend: const Legend(
                    padding: 0,
                    isVisible: true,
                  ),
                  series: <CircularSeries>[
                    // Render pie chart
                    PieSeries<ChartData, String>(
                      dataSource: [
                        // Bind data source
                        ChartData(
                            '%>=75:', (above75Student / totalStudent) * 100),
                        ChartData('60<%<75:',
                            (above60below75Student / totalStudent) * 100),
                        ChartData(
                            '%<=60:', (below60Student / totalStudent) * 100),
                        ChartData('Special:', (0 / totalStudent) * 100),
                      ],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      radius: '85%',
                    )
                  ],
                ),
              ),
              BottomText(
                title: "Total Students:",
                count: totalStudent,
                list: total,
              ),
              BottomText(
                title: "Above 75%:",
                count: above75Student,
                color: Colors.green,
                textColor: Colors.white,
                list: above75,
              ),
              BottomText(
                title: "Below 75%:",
                count: below75.length,
                color: Colors.orange,
                list: below75,
              ),
              BottomText(
                title: "Above 60% and below 75%:",
                count: above60below75Student,
                color: Colors.yellow,
                list: above60below75,
              ),
              BottomText(
                title: "Below 60%:",
                count: below60Student,
                color: Colors.red,
                textColor: Colors.white,
                list: below60,
              ),
              BottomText(
                title: "Special Case:",
                count: 00,
                color: Colors.green,
                textColor: Colors.white,
                list: special,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final Color textColor;
  final List<dynamic> list;
  const BottomText({
    super.key,
    this.title = "Title",
    this.count = 0,
    this.color = Colors.transparent,
    this.textColor = Colors.black,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, AttendancePercentageList.id,
            arguments: {"data": list, "title": title});
      },
      child: Row(
        children: [
          Text(
            "   $title",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              backgroundColor: color,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget({super.key, this.text = "Text"});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
