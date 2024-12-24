// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:attendance/components/input_box.dart';
import 'package:attendance/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentListUpload extends StatefulWidget {
  static String id = 'upload_student_list';
  const StudentListUpload({super.key});

  @override
  State<StudentListUpload> createState() => _StudentListUploadState();
}

class _StudentListUploadState extends State<StudentListUpload> {
  PlatformFile? file;
  String text = "";
  FilePickerResult? result;
  TextEditingController branch = TextEditingController();
  TextEditingController batch = TextEditingController();
  String section = "";
  bool isReady = false;
  bool spinner = false;

  Future<void> pickSingleFile() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result!.files.first;
      print(file.path);
      print(file.name);
      setState(() {
        text = file.name;
        if (branch.text != "" && batch.text != "" && section != "") {
          isReady = true;
        }
      });
    } else {
      print("select valid file");
    }

    // file == null ? false : OpenAppFile.open(file!.path.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ModalProgressHUD(
          inAsyncCall: spinner,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputBox(
                    textController: branch,
                    label: "Enter Branch(Like CSE)*",
                  ),
                  InputBox(
                    textController: batch,
                    label: "Enter batch(Like:2021-25)*",
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        label: const Text(
                          "Section*",
                          style: TextStyle(fontSize: 25),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        style: const TextStyle(
                            color: kInactiveTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        isExpanded: true,
                        value: section,
                        onChanged: (x) {
                          setState(() {
                            section = x!;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: "",
                            child: Text("Section"),
                          ),
                          DropdownMenuItem(
                            value: "01",
                            child: Text("01"),
                          ),
                          DropdownMenuItem(
                            value: "02",
                            child: Text("02"),
                          ),
                          DropdownMenuItem(
                            value: "03",
                            child: Text("03"),
                          ),
                          DropdownMenuItem(
                            value: "04",
                            child: Text("04"),
                          ),
                          DropdownMenuItem(
                            value: "05",
                            child: Text("05"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: pickSingleFile,
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    icon: const Icon(Icons.insert_drive_file_sharp),
                    label: Text(
                      text == "" ? 'Choose file' : text,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: TextButton(
                      onPressed: () {
                        isReady
                            ? showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Upload List'),
                                  content: const Text('Are you Sure?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // print(data);
                                        setState(() {
                                          spinner = true;
                                        });
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        String? authorization =
                                            prefs.getString('authorization');
                                        String uploadUrl =
                                            "$kAdminPath/uploadStudentList"; // Replace with your Node.js server endpoint
                                        PlatformFile file = result!.files.first;
                                        var request = http.MultipartRequest(
                                            'POST', Uri.parse(uploadUrl));

                                        // Add file to the request
                                        request.files.add(
                                          await http.MultipartFile.fromPath(
                                            'file', // Key for the file on the server
                                            file.path!,
                                          ),
                                        );
                                        request.fields['Branch'] = "CSE";
                                        request.fields['batch'] = '2021-25';
                                        request.fields['section'] = section;

                                        // Send the request
                                        http.StreamedResponse response =
                                            await request.send();
                                        print(response.stream);
                                        // Handle the response
                                        if (response.statusCode == 200) {
                                          print("File uploaded successfully!");
                                          var responseBody = await response
                                              .stream
                                              .bytesToString();
                                          print(responseBody);
                                        } else {
                                          print(
                                              "File upload failed: ${response.statusCode}");
                                        }
                                        setState(() {
                                          spinner = false;
                                        });
                                        if (!context.mounted) return;
                                        Navigator.pop(context);
                                        // var response = await http.post(
                                        //   Uri.parse("$kAdminPath/modifyTimetable"),
                                        //   headers: {
                                        //     "Accept": "*/*",
                                        //     "Content-Type": "application/json",
                                        //     "authorization": authorization ?? "",
                                        //   },
                                        //   body: jsonEncode(data),
                                        //   encoding: Encoding.getByName('utf-8'),
                                        // );
                                        // // print(response.body);
                                        // if (response.statusCode == 200) {
                                        //   if (!context.mounted) return;
                                        //   Navigator.pop(context);
                                        // }
                                      },
                                      child: const Text('Yes'),
                                    )
                                  ],
                                ),
                              )
                            : "";
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            isReady ? Colors.green : Colors.green.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: const Text(
                        "Upload",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
