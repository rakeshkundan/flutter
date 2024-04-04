import 'package:attendance/Data/profile_data.dart';
import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: "ProfilePic",
                transitionOnUserGestures: true,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/manit_logo.jpg'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InputRow(
                title: 'Name',
                icon: Icons.person,
                initialData: Provider.of<ProfileData>(context).name!,
                helpText:
                    'This is not your pin or username.This Name Will be visible to Your Friends',
              ),
              InputRow(
                title: 'Branch',
                icon: FontAwesomeIcons.codeBranch,
                initialData: Provider.of<ProfileData>(context).department!,
              ),
              InputRow(
                title: 'Employee Code',
                icon: Icons.numbers,
                initialData: Provider.of<ProfileData>(context).employeeId!,
                divider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: kInactiveTextColor),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      initialData,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  helpText,
                  style: const TextStyle(color: kInactiveTextColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              divider ? const Divider() : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
