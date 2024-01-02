// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/screen/home.dart';
import 'package:movie/utilities/category_list.dart';
import 'package:provider/provider.dart';
import '../components/app_title.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_bar.dart';
import '../widgets/movie_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  static String id = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> list = [
    MovieBar(
      cardTitle: "Latest Releases",
      searchId: 'now_playing',
    ),
    MovieBar(
      cardTitle: "Coming Soon",
      searchId: 'upcoming',
    ),
    MovieBar(
      cardTitle: "Popular",
      searchId: 'popular',
    ),
    MovieBar(
      cardTitle: "Top Rated",
      searchId: 'top_rated',
    ),
  ];
  void updateCategory() {
    list = [];

    list.add(MovieBar(
      cardTitle: Provider.of<CategoryList>(context).title,
      searchId: Provider.of<CategoryList>(context).searchId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTitle(
            titleText: 'Browse',
            titleIcon: Icons.notifications_none_outlined,
          ),
          Searchbar(
            hintText: 'Search by Name,Genre or Award',
          ),
          SizedBox(
            height: 10.0,
          ),
          CategoryBar(
            updateList: updateCategory,
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            flex: 7,
            child: RefreshIndicator(
              onRefresh: () async {
                Navigator.pop(context);
                Navigator.pushNamed(context, Home.id);
              },
              child: ListView(
                padding: EdgeInsets.only(bottom: 110.0),
                children: Provider.of<CategoryList>(context).activeList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
// class ListMaker extends StatefulWidget {
//   const ListMaker({super.key});
//
//   @override
//   State<ListMaker> createState() => _ListMakerState();
// }
//
// class _ListMakerState extends State<ListMaker> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.only(bottom: 110.0),
//       children: Provider.of<CategoryList>(context).activeList,
//     );
//   }
// }
