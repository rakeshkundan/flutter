// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/components/movies_row.dart';
import 'package:movie/constants.dart';
import 'package:movie/components/app_title.dart';
import 'package:movie/data/profile_data.dart';
import 'package:movie/models/contact.dart';
import 'package:movie/models/database.dart';
import 'package:movie/services/networking.dart';
import 'package:movie/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class CircleScreen extends StatelessWidget {
  static String id = 'circle_screen';
  TextEditingController name = TextEditingController();
  TextEditingController num = TextEditingController();
  CircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool login = Provider.of<ProfileData>(context).isProfileSet;
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTitle(
            titleText: 'Circles',
            titleIcon: FontAwesomeIcons.userPlus,
            onIconPress: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 50,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Add Contact",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      TextField(
                        controller: name,
                        decoration: InputDecoration(hintText: 'Enter name'),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: num,
                        decoration: InputDecoration(hintText: 'Enter Number'),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () async {
                          print(login);
                          if (!login) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Login issue!"),
                                content: const Text("Please Login First"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      // color: Colors.green,

                                      padding: const EdgeInsets.all(14),
                                      child: const Text(
                                        "Ok",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            try {
                              // print(name.text);

                              DatabaseHelper dbHelp = DatabaseHelper.instance;
                              final id = await dbHelp.insertContact(
                                  Contact(name.text, num.text, '', 0, ''));
                              // print(id);
                            } catch (e) {
                              print(e);
                            }
                            if (!context.mounted) return;
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Searchbar(
            hintText: 'Search for Friends by Name',
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        CircleAvatar(
                          backgroundColor: kIconColor,
                          child: CircleAvatar(
                            radius: 33,
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: -4,
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: kDefaultIconDarkColor,
                            child: Center(
                              child: Icon(
                                Icons.add_circle_outline_outlined,
                                color: kIconColor,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CircleAvatar(
                      radius: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CircleAvatar(
                      radius: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CircleAvatar(
                      radius: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CircleAvatar(
                      radius: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CircleAvatar(
                      radius: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CircleAvatar(
                      radius: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 120),
              scrollDirection: Axis.vertical,
              children: [
                FriendBar(),
                FriendBar(),
                FriendBar(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FriendBar extends StatelessWidget {
  const FriendBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 23,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Rakesh kundan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -1,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Unfollow',
                            style: TextStyle(
                              color: kInactiveTextColor,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '@rakeshkundan',
                      style: TextStyle(
                        fontSize: 15,
                        color: kInactiveTextColor,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'See all',
                  style: TextStyle(color: kIconColor),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MoviesRow(
          netHelp: NetworkHelper(
              url:
                  'https://api.themoviedb.org/3/movie/now_playing?api_key=b195f787962173c1ee91ddc986379adc&region=IN&page=1'),
        ),
      ],
    );
  }
}
