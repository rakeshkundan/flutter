// ignore_for_file: must_be_immutable

// import 'package:attendance/Screen/Auth/change_password.dart';
import 'package:attendance/Screen/SupportScreen/setting.dart';
import 'package:attendance/Screen/initial_screen.dart';
import 'package:attendance/Utilities/global_functions.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:attendance/Data/profile_data.dart';
import 'package:attendance/models/database.dart';
import 'package:attendance/Screen/SupportScreen/profile_detail_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile_screen';
  ProfileScreen({super.key});
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProfileDetailScreen.id);
            },
            child: Hero(
              tag: "ProfilePic",
              transitionOnUserGestures: true,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 70,
                child: Image.asset('assets/images/manit_logo.jpg'),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              '${Provider.of<ProfileData>(context).name}',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          // TextButton(
          //   style: TextButton.styleFrom(
          //     padding: const EdgeInsets.all(0),
          //   ),
          //   onPressed: () {
          //     Navigator.pushNamed(context, ProfileDetailScreen.id);
          //   },
          //   child: const Text(
          //     'View Profile',
          //     style: TextStyle(
          //       color: kInactiveTextColor,
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                RowItem(
                  icon: Icons.history_sharp,
                  text: 'History',
                  onPress: () {},
                ),
                RowItem(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
                  onPress: () {
                    Navigator.pushNamed(context, Setting.id);
                  },
                ),
                RowItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onPress: () {
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
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPress;
  const RowItem(
      {super.key,
      this.text = 'text',
      this.icon = Icons.rectangle_outlined,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: Colors.grey.shade700,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
