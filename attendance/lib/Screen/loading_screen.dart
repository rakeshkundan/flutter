// ignore_for_file: use_build_context_synchronously

import 'package:attendance/Data/student_detail.dart';
import 'package:attendance/Screen/SupportScreen/attendance_screen.dart';
import 'package:attendance/Utilities/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  static String id = "loading_screen";
  final String section;
  const LoadingScreen({super.key, this.section = ''});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void setActive() async {
    NetworkHelper nethelp = NetworkHelper(url: 'http://localhost:3000/');
    List<dynamic> data = await nethelp.getData();
    // print(data);
    if (!context.mounted) return;
    Provider.of<StudentDetail>(context, listen: false).setData(data);

    if (!mounted) return;
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      AttendanceScreen.id,
      arguments: {'data': data},
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setActive();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitFadingCircle(
        color: Colors.grey,
      )),
    );
  }
}
