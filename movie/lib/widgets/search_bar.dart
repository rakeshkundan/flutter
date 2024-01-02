// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie/constants.dart';
import 'package:movie/screen/search_result.dart';
import 'package:movie/services/networking.dart';

class Searchbar extends StatelessWidget {
  final String hintText;
  const Searchbar({
    super.key,
    this.hintText = 'This is hint Text',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              decoration: BoxDecoration(
                color: Color(0xFF2B2B2B),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                onSubmitted: (query) async {
                  NetworkHelper nethelp = NetworkHelper(
                      url:
                          'https://api.themoviedb.org/3/search/movie?api_key=b195f787962173c1ee91ddc986379adc&query=$query');
                  var data = await nethelp.getData();
                  if (!context.mounted) return;
                  Navigator.pushNamed(context, SearchResult.id,
                      arguments: {'searchData': data, 'Query': query});
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: kInactiveTextColor,
                    fontSize: 15.0,
                  ),
                  icon: Icon(
                    Icons.search,
                    color: kIconColor,
                    size: 35.0,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Icon(
            Icons.filter_list_alt,
            color: kIconColor,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
