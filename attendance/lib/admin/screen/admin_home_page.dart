// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:attendance/Screen/initial_screen.dart';
import 'package:attendance/Utilities/global_functions.dart';
import 'package:attendance/admin/screen/add_timetable.dart';
import 'package:attendance/admin/screen/modify_timetable_page.dart';
import 'package:attendance/components/dashboard_card.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';

class AdminsHomePage extends StatefulWidget {
  static String id = 'admin_home_page';
  const AdminsHomePage({super.key});

  @override
  State<AdminsHomePage> createState() => _AdminsHomePageState();
}

class _AdminsHomePageState extends State<AdminsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin panel"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              DashboardCard(
                icon: Icons.change_circle_outlined,
                title: "Modify Class",
                onClick: () {
                  Navigator.pushNamed(context, ModifyTimetable.id);
                },
              ),
              DashboardCard(
                icon: Icons.add,
                title: "Add Class",
                onClick: () {
                  Navigator.pushNamed(context, AddTimetable.id);
                },
              ),
              DashboardCard(
                icon: Icons.remove_circle_outline,
                title: "Remove Class",
                onClick: () {},
              ),
              DashboardCard(
                icon: Icons.logout,
                title: "Logout",
                onClick: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirm!'),
                        content: const Text('Are you sure wants to logout?'),
                        actions: [
                          RawMaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                // color: kInactiveTextColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 7.0),
                              child: Text(
                                'Cancel',
                                style: kAlertButtonTextStyle,
                              ),
                            ),
                          ),
                          RawMaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () async {
                              GlobalFunction gf = GlobalFunction();
                              await gf.logOut();
                              if (!context.mounted) return;
                              Navigator.popUntil(context, (route) => false);
                              Navigator.pushNamed(context, InitialScreen.id);
                            },
                            // {
                            //   DatabaseHelper dbHelp = DatabaseHelper.instance;
                            //   bool flag = await dbHelp.deleteDb();
                            //   SharedPreferences prefs =
                            //       await SharedPreferences.getInstance();
                            //   // if (response.statusCode == 200) {
                            //   await prefs.setBool('isLoggedIn', false);
                            //   await prefs.setString('authorization', "");
                            //   if (!context.mounted) return;
                            //   Navigator.popUntil(context, (route) => false);
                            //   Navigator.pushNamed(context, InitialScreen.id);
                            //   // if (!context.mounted) return;
                            //   // Provider.of<Session>(context, listen: false)
                            //   //     .updateCookie(response);
                            //   // }
                            //
                            //   // if (flag) {
                            //   //   if (!context.mounted) return;
                            //   //   Provider.of<ProfileData>(context,
                            //   //           listen: false)
                            //   //       .setIsProfileSet(false);
                            //   //   Navigator.pop(context);
                            //   // } else {
                            //   //   if (!context.mounted) return;
                            //   //   Navigator.pop(context);
                            //   //   showDialog(
                            //   //       context: context,
                            //   //       builder: (context) {
                            //   //         return AlertDialog(
                            //   //           title: const Text('Error!!'),
                            //   //           content: const Text(
                            //   //               'Some Unexpected Error.Please restart the app.'),
                            //   //           actions: [
                            //   //             RawMaterialButton(
                            //   //               onPressed: () {
                            //   //                 Navigator.pop(context);
                            //   //               },
                            //   //               child: Text('ok'),
                            //   //             ),
                            //   //           ],
                            //   //         );
                            //   //       });
                            //   // }
                            // },
                            child: Container(
                              decoration: BoxDecoration(
                                // color: kInactiveTextColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 7.0),
                              child: Text(
                                'Ok',
                                style: kAlertButtonTextStyle,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
