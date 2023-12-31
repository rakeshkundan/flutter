// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie/screen/movie_detail_screen.dart';

class MovieTile extends StatelessWidget {
  final dynamic movieData;

  const MovieTile({super.key, this.movieData});

  @override
  Widget build(BuildContext context) {
    try {
      return Padding(
        padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, MovieDetailScreen.id,
                arguments: {'data': movieData});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: Image(
                  height: 160.0,
                  width: 100.0,
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${movieData['poster_path'] ?? '/yOm993lsJyPmBodlYjgpPwBjXP9.jpg'}'),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 100.0,
                padding: EdgeInsets.all(5.0),
                child: Text(
                  '${movieData['title']}',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 0,
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}
