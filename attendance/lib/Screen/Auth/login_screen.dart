// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_import, must_be_immutable, avoid_print, unused_local_variable, unnecessary_null_comparison

import 'dart:convert';

import 'package:attendance/Data/profile_data.dart';
import 'package:attendance/Data/state_data.dart';
import 'package:attendance/Data/time_table.dart';
import 'package:attendance/Utilities/networking.dart';
import 'package:attendance/constants.dart';
import 'package:attendance/models/database.dart';
import 'package:attendance/models/user.dart';
import 'package:flutter/material.dart';
import 'package:local_captcha/local_captcha.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attendance/Screen/home.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  static String id = "login_screen";
  LoginScreen({super.key});
  TextEditingController empController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController textControl = TextEditingController();
  LocalCaptchaController localCaptcha = LocalCaptchaController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<TimeTable>(context).progressBar,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
              ),
              Hero(
                tag: "ManitLogo",
                transitionOnUserGestures: true,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 80,
                  child: Image.asset('./assets/images/manit_logo.jpg'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InputBox(
                label: 'Employee Id',
                textController: empController,
              ),

              InputBox(
                label: 'Password',
                textController: passController,
                obscText: true,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              // Captcha(
              //   captchaController: textControl,
              //   localCaptcha: localCaptcha,
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              //   // height: 70,
              //   child: TextField(
              //     controller: textControl,
              //     textAlign: TextAlign.center,
              //     decoration: InputDecoration(
              //
              //         // error: Text("Wrong Captcha!!"),
              //         hintText: "Enter Captcha",
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //         fillColor: Colors.grey.shade700,
              //         focusColor: Colors.grey.shade700),
              //   ),
              // ),
              RawMaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () async {
                  if (empController.text == "" || passController.text == "") {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Alert!'),
                          content: const Text(
                              'Employee id or Password cannot be Empty.'),
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
                                  'Ok',
                                  style: kAlertButtonTextStyle,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  Provider.of<TimeTable>(context, listen: false)
                      .setProgressBar(true);
                  try {
                    var response = await http.post(
                      Uri.parse('$kBaseLink/api/user/signIn'),
                      headers: {
                        "Accept": "*/*",
                        "Content-Type": "application/json"
                      },
                      body: jsonEncode({
                        "employeeCode": empController.text,
                        "password": passController.text
                      }),
                      encoding: Encoding.getByName('utf-8'),
                    );
                    // print(response.body);
                    var data =
                        response != null ? jsonDecode(response.body) : {};

                    if (response.statusCode == 200) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(
                          'authorization', data['authorization']);
                      Map<String, dynamic> row = {
                        DatabaseHelper.employeeId: empController.text,
                        DatabaseHelper.department: data['department'],
                        DatabaseHelper.name: data['name'] ?? "User",
                      };
                      DatabaseHelper dbHelper = DatabaseHelper.instance;
                      User user = User.fromMap(row);
                      final id = await dbHelper.insertUser(user);

                      if (!context.mounted) return;
                      await Provider.of<ProfileData>(context, listen: false)
                          .setIsProfileSet(true);
                      if (!context.mounted) return;
                      await prefs.setBool('isLoggedIn', true);

                      if (!context.mounted) return;
                      Navigator.popAndPushNamed(context, Home.id);
                      Provider.of<TimeTable>(context, listen: false)
                          .setProgressBar(false);
                    } else {
                      if (!context.mounted) return;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Alert!'),
                            content:
                                const Text('Employee id or Password is Wrong.'),
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
                                    'Ok',
                                    style: kAlertButtonTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      Provider.of<TimeTable>(context, listen: false)
                          .setProgressBar(false);
                    }

                    // if (!context.mounted) return;
                    // NetworkHelper nethelp = NetworkHelper(
                    //   url:
                    //       "$kScheduleLink?day=${Provider.of<StateData>(context, listen: false).selectedDay.weekday}",
                    //   head: true,
                    // );

                    // print(await nethelp.getData());
                    // await Provider.of<TimeTable>(context, listen: false)
                    //     .setSchedule(await nethelp.getData());
                  } catch (e) {
                    Provider.of<TimeTable>(context, listen: false)
                        .setProgressBar(false);
                    if (!context.mounted) return;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Alert!'),
                          content: const Text('Network Error!!'),
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
                                  'Ok',
                                  style: kAlertButtonTextStyle,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    print(e);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 7.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Captcha extends StatefulWidget {
  final TextEditingController captchaController;
  final LocalCaptchaController localCaptcha;
  const Captcha(
      {super.key, required this.captchaController, required this.localCaptcha});

  @override
  State<Captcha> createState() => _CaptchaState();
}

class _CaptchaState extends State<Captcha> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LocalCaptcha(
            controller: widget.localCaptcha,
            height: 70,
            width: 250,
            // caseSensitive: true,
          ),
          ElevatedButton(
            onPressed: () => widget.localCaptcha.refresh(),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
            ),
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

// class Captcha extends StatelessWidget {
//   const Captcha({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           LocalCaptcha(
//             controller: Provider.of<StateData>(context).localCaptcha,
//             height: 70,
//             width: 250,
//           ),
//           ElevatedButton(
//             onPressed: () =>
//                 Provider.of<StateData>(context).localCaptcha.refresh(),
//             style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.zero,
//               minimumSize: Size(0, 0),
//             ),
//             child: Icon(Icons.refresh),
//           ),
//         ],
//       ),
//     );
//   }
// }

class InputBox extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final bool obscText;

  const InputBox({
    super.key,
    this.label = "label",
    required this.textController,
    this.obscText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        obscureText: obscText,
        controller: textController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 20),
          floatingLabelStyle: MaterialStateTextStyle.resolveWith(
            (Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : Colors.grey.shade700;
              return TextStyle(color: color, letterSpacing: 1.3, fontSize: 25);
            },
          ),
        ),
        // validator: (String? value) {
        //   if (value == null || value == '') {
        //     return 'Enter name';
        //   }
        //   return null;
        // },
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}
