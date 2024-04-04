// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_null_comparison, avoid_print

import 'dart:convert';

import 'package:attendance/Data/time_table.dart';
import 'package:attendance/Screen/Auth/login_screen.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatelessWidget {
  static String id = "change_password";
  ChangePassword({super.key});
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<TimeTable>(context).progressBar,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change Password"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              InputBox(
                label: 'Old Password',
                textController: oldPassController,
                obscText: true,
              ),
              InputBox(
                label: 'New Password',
                textController: newPassController,
                obscText: true,
              ),
              InputBox(
                label: 'Confirm New Password',
                textController: confirmPassController,
                obscText: true,
              ),
              RawMaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () async {
                  if (oldPassController.text == "" ||
                      newPassController.text == "" ||
                      confirmPassController.text == "") {
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

                  try {
                    Provider.of<TimeTable>(context, listen: false)
                        .setProgressBar(true);
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String auth = prefs.getString('authorization') ?? "";
                    var response = await http.put(
                      Uri.parse('$kBaseLink/api/user/changePassword'),
                      headers: {
                        "Accept": "*/*",
                        "Content-Type": "application/json",
                        "authorization": auth
                      },
                      body: jsonEncode({
                        "oldPassword": oldPassController.text,
                        "newPassword": newPassController.text,
                        "confirmNewPassword": confirmPassController.text
                      }),
                      encoding: Encoding.getByName('utf-8'),
                    );

                    var data =
                        response != null ? await jsonDecode(response.body) : {};
                    print(data);
                    String message = data['message'];
                    if (!context.mounted) return;
                    Provider.of<TimeTable>(context, listen: false)
                        .setProgressBar(false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Message'),
                          content: Text(message),
                          actions: [
                            RawMaterialButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
                                if (message ==
                                    "Password Changed Successfully.") {
                                  Navigator.pop(context);
                                }
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
                    // Navigator.pop(context);
                  } catch (e) {
                    // print(e);
                    Provider.of<TimeTable>(context, listen: false)
                        .setProgressBar(false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Message'),
                          content: Text("Something Went Wrong."),
                          actions: [
                            RawMaterialButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
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
                  }
                  // } else {
                  //   //
                  // }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 7.0),
                  child: Text(
                    'Submit',
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
