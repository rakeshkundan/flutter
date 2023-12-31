// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:movie/components/movies_row.dart';
import 'package:movie/constants.dart';
import 'package:movie/services/networking.dart';
import 'package:movie/utilities/category_list.dart';
import 'package:provider/provider.dart';

class MovieBar extends StatelessWidget {
  final String cardTitle;
  final String searchId;
  const MovieBar(
      {super.key, this.cardTitle = "Title", this.searchId = 'now_playing'});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardTitle,
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w700),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<CategoryList>(context, listen: false)
                      .setSeeAll(cardTitle);
                  // setState(() {});
                },
                child: Text(
                  'See ${(Provider.of<CategoryList>(context).isSeeAll(cardTitle) == false) ? 'all' : 'less'}',
                  style: TextStyle(
                    color: kIconColor,
                    fontSize: 15.0,
                  ),
                ),
              )
            ],
          ),
        ),
        MoviesRow(
          catTitle: cardTitle,
          netHelp: NetworkHelper(
              url:
                  'https://api.themoviedb.org/3/movie/$searchId?api_key=b195f787962173c1ee91ddc986379adc&region=IN&page=1'),
        ),
      ],
    );
  }
}

// class MoviesRow extends StatefulWidget {
//   final NetworkHelper netHelp;
//   final String catTitle;
//   const MoviesRow(
//       {super.key, required this.netHelp, this.catTitle = 'Coming Soon'});
//
//   @override
//   State<MoviesRow> createState() => _MoviesRowState();
// }
//
// class _MoviesRowState extends State<MoviesRow> {
//   dynamic movieData;
//
//   List<Widget> rowBuilder(var movieList) {
//     List<Widget> newList = [];
//     for (var movie in movieList) {
//       try {
//         newList.add(
//           MovieTile(
//             movieData: movie,
//           ),
//         );
//       } catch (e) {
//         // print(e);
//       }
//     }
//     return newList;
//   }
//
//   List<Row> expandedBuilder(var movieList) {
//     List<Row> newList = [];
//     for (int i = 0; i < movieList.length; i++) {
//       List<MovieTile> temp = [];
//       while (i < movieList.length) {
//         try {
//           temp.add(
//             MovieTile(
//               movieData: movieList[i],
//             ),
//           );
//         } catch (e) {
//           // print(e);
//         }
//
//         if (temp.length == 3) break;
//         i++;
//       }
//       if (temp.isNotEmpty) {
//         newList.add(Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: temp,
//         ));
//       }
//     }
//     return newList;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     movieData = widget.netHelp.getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     try {
//       return FutureBuilder(
//         future: movieData,
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
//           if (snapShot.hasData) {
//             var data = snapShot.data;
//
//             return !(Provider.of<CategoryList>(context)
//                     .isSeeAll(widget.catTitle))
//                 ? SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: rowBuilder(data['results']),
//                     ),
//                   )
//                 : Wrap(
//                     children: rowBuilder(data['results']),
//                   );
//             //   SingleChildScrollView(
//             //   scrollDirection: Axis.horizontal,
//             //   child:
//             //       Provider.of<CategoryList>(context).isSeeAll(widget.catTitle)
//             //           ? Column(
//             //               crossAxisAlignment: CrossAxisAlignment.center,
//             //               children: expandedBuilder(data['results']),
//             //             )
//             //           : Row(
//             //               crossAxisAlignment: CrossAxisAlignment.start,
//             //               children: rowBuilder(data['results']),
//             //             ),
//             // );
//           } else if (snapShot.hasError) {
//             return Text('Network Problem!');
//           }
//           return SpinKitRing(
//             color: kIconColor,
//           );
//         },
//       );
//     } catch (e) {
//       return Center(
//         child: Text("Network Problem"),
//       );
//     }
//   }
// }
