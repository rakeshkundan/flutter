import 'package:attendance/Screen/SupportScreen/analysis_detail_finder.dart';
import 'package:attendance/Screen/SupportScreen/attendance_download_screen.dart';
import 'package:attendance/components/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatelessWidget {
  static String id = "dashboard_screen";
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                DashboardCard(
                  onClick: () {
                    Navigator.pushNamed(context, AttendanceDownloadScreen.id);
                  },
                  icon: Icons.poll_outlined,
                  title: "Attendance",
                ),
                DashboardCard(
                  onClick: () {
                    Navigator.pushNamed(context, AnalysisDetailFinderScreen.id);
                  },
                  icon: Icons.analytics,
                  title: "Analyse",
                ),
                DashboardCard(
                  icon: Icons.calendar_month_outlined,
                  title: "Reschedule",
                  onClick: () {},
                ),
                DashboardCard(
                  onClick: () {},
                  title: "TimeTable",
                  icon: FontAwesomeIcons.calendarCheck,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
