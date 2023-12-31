// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie/components/movie_tile.dart';

class SearchResult extends StatelessWidget {
  static String id = 'search_result';
  dynamic result;
  SearchResult({super.key});
  List<Widget> rowBuilder(var movieList) {
    // print(movieList);
    List<Widget> newList = [
      SizedBox(
        width: 10.0,
      )
    ];
    for (var movie in movieList) {
      try {
        newList.add(
          MovieTile(
            movieData: movie,
          ),
        );
      } catch (e) {
        // print(e);
      }
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    result = (ModalRoute.of(context)!.settings.arguments as Map);
    // print(result);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Search Result',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            Text(
              'Showing Result for ${result['Query'] ?? 'Query'}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: rowBuilder(result['searchData']['results']),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('<<Prev'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Next>>'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
