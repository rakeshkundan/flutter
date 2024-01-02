// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/constants.dart';
import 'package:movie/data/profile_data.dart';
import 'package:movie/data/state_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetailScreen extends StatelessWidget {
  static String id = 'profile_detail_screen';
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
      ),
      body: SafeArea(
        // top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 10.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      backgroundColor: kInactiveTextColor,
                      child: Text(
                        Provider.of<ProfileData>(context).name![0],
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -25,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Color(0xFFF5F6F9),
                        padding: EdgeInsets.all(5.0),
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: kInactiveTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InputRow(
                title: 'Name',
                icon: Icons.person,
                initialData: Provider.of<ProfileData>(context).name!,
                helpText:
                    'This is not your pin or username.This Name Will be visible to Your Friends',
              ),
              InputRow(
                title: 'About',
                icon: FontAwesomeIcons.circleInfo,
                initialData: Provider.of<ProfileData>(context).about!,
              ),
              InputRow(
                title: 'Phone',
                icon: Icons.phone,
                initialData: Provider.of<ProfileData>(context).phone!,
                divider: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class InputRow extends StatefulWidget {
//   final String title;
//   final IconData icon;
//   final String initialData;
//   final String helpText;
//   final bool divider;
//   const InputRow({
//     super.key,
//     this.divider = true,
//     this.title = 'Title',
//     this.icon = Icons.rectangle_outlined,
//     this.initialData = '',
//     this.helpText = '',
//   });
//
//   @override
//   State<InputRow> createState() => _InputRowState();
// }
//
// class _InputRowState extends State<InputRow> {
//   bool isEdit = false;
//   bool isFocus = false;
//   Future<String> getData(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     dynamic data = prefs.getString(key);
//     return data;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           widget.icon,
//           size: 35,
//         ),
//         SizedBox(
//           width: 20.0,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.title,
//                 style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w700,
//                     color: kInactiveTextColor),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       style: TextStyle(fontSize: 20),
//                       controller:
//                           TextEditingController(text: widget.initialData),
//                       keyboardType: TextInputType.name,
//                       onSubmitted: (value) async {
//
//                         Provider.of<ProfileData>(context, listen: false)
//                             .updateData(widget.title, value);
//                       },
//                       cursorColor: Colors.white,
//                       readOnly: !isEdit,
//                       decoration: InputDecoration(
//                         enabled: true,
//                         labelStyle: TextStyle(
//                           fontSize: 30,
//                           color: Colors.white,
//                         ),
//                         focusedBorder: isEdit
//                             ? UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white))
//                             : InputBorder.none,
//                         enabledBorder: isEdit
//                             ? UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white))
//                             : InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                         focusColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         isEdit = !isEdit;
//                       });
//                     },
//                     child: Icon(
//                       Icons.edit,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 10.0),
//                 child: Text(
//                   widget.helpText,
//                   style: TextStyle(color: kInactiveTextColor),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               widget.divider ? Divider() : SizedBox(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class InputRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final String initialData;
  final String helpText;
  final bool divider;
  const InputRow({
    super.key,
    this.divider = true,
    this.title = 'Title',
    this.icon = Icons.rectangle_outlined,
    this.initialData = '',
    this.helpText = '',
  });

  Future<String> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic data = prefs.getString(key);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 35,
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: kInactiveTextColor),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      controller: TextEditingController(text: initialData),
                      keyboardType: TextInputType.name,
                      onSubmitted: (value) async {
                        Provider.of<ProfileData>(context, listen: false)
                            .updateData(title, value);
                      },
                      cursorColor: Colors.white,
                      readOnly: !Provider.of<StateData>(context).getEdit(title),
                      decoration: InputDecoration(
                        enabled: true,
                        labelStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                        focusedBorder:
                            Provider.of<StateData>(context).getEdit(title)
                                ? UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white))
                                : InputBorder.none,
                        enabledBorder:
                            Provider.of<StateData>(context).getEdit(title)
                                ? UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white))
                                : InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusColor: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<StateData>(context, listen: false)
                          .setEdit(title);
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  helpText,
                  style: TextStyle(color: kInactiveTextColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              divider ? Divider() : SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
