// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisScreen extends StatefulWidget {
  static String id = "analysis_screen";
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int? totalCount;
  List<dynamic> total = [];
  List<dynamic> above75 = [];
  List<dynamic> above60below75 = [];
  List<dynamic> below60 = [];
  int totalStudent = 1,
      above75Student = 1,
      above60below75Student = 1,
      below60Student = 1;

  void calculateAttendance(data) {
    if (data != null) {
      totalCount = data['data']['total'];
      // print(data['data']['cumulativeAttendance']);
      for (var item in data['data']['cumulativeAttendance'].entries) {
        var percent = item.value / totalCount;
        total.add(item);
        // print(item);

        if (percent >= 0.75) {
          above75.add(item);
        } else if (percent < .75 && percent >= .60) {
          above60below75.add(item);
        } else {
          below60.add(item);
        }
      }
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
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    calculateAttendance(arguments);
    // print(arguments);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextWidget(
                text: "Batch 25",
              ),
              TextWidget(
                text: "CSE",
              ),
              TextWidget(
                text: "Section 1",
              ),
              SfCircularChart(
                onSelectionChanged: (e) {
                  print(e);
                },
                palette: [
                  Colors.green,
                  Colors.yellow,
                  Colors.red,
                  Colors.lightGreen
                ],
                title: ChartTitle(text: 'Class Analysis'),
                legend: Legend(
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
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    radius: '85%',
                  )
                ],
              ),
              BottomText(
                title: "Total Students:",
                count: totalStudent,
              ),
              BottomText(
                title: "Above 75%:",
                count: above75Student,
                color: Colors.green,
                textColor: Colors.white,
              ),
              BottomText(
                title: "Above 60% and below 75%:",
                count: above60below75Student,
                color: Colors.yellow,
              ),
              BottomText(
                title: "Below 60%:",
                count: below60Student,
                color: Colors.red,
                textColor: Colors.white,
              ),
              BottomText(
                title: "Special Case:",
                count: 00,
                color: Colors.green,
                textColor: Colors.white,
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
  const BottomText({
    super.key,
    this.title = "Title",
    this.count = 0,
    this.color = Colors.transparent,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "   $title",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
      style: TextStyle(
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
