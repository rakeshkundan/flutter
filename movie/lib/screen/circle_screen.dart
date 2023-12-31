// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/components/movies_row.dart';
import 'package:movie/constants.dart';
import 'package:movie/data/app_title.dart';
import 'package:movie/services/networking.dart';
import 'package:movie/widgets/search_bar.dart';
import 'package:movie/widgets/bottom_nav_bar.dart';

class CircleScreen extends StatelessWidget {
  static String id = 'circle_screen';
  const CircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTitle(
                  titleText: 'Circles',
                  titleIcon: FontAwesomeIcons.userPlus,
                  onIconPress: () {},
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: CircleAvatar(
                            radius: 30,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: CircleAvatar(
                            radius: 30,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: CircleAvatar(
                            radius: 30,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: CircleAvatar(
                            radius: 30,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: CircleAvatar(
                            radius: 30,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
            Positioned(
              bottom: 25.0,
              left: 0.0,
              right: 0.0,
              child: BottomNavBar(),
            ),
          ],
        ),
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
                            fontWeight: FontWeight.bold,
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
