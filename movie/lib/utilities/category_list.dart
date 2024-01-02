// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'category.dart';
import 'package:movie/widgets/movie_bar.dart';

class CategoryList extends ChangeNotifier {
  int active = 0;
  List<Category> category = [
    Category(text: 'All', isChecked: true),
    Category(text: 'Latest Releases', searchId: 'now_playing'),
    Category(text: 'Coming Soon', searchId: 'upcoming'),
    Category(text: 'Popular', searchId: 'popular'),
    Category(text: 'Top rated', searchId: 'top_rated'),
  ];
  List<Widget> activeList = [
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
  void refreshActiveList() {
    notifyListeners();
  }

  String get title => category[active].text;
  String get searchId => category[active].searchId;

  Category getCategory(int index) {
    return category[index];
  }

  void setActive(int index) {
    category[active].toggleIsChecked();
    category[index].toggleIsChecked();
    for (var item in category) {
      item.isSeeAll = false;
    }

    active = index;
    if (active == 0) {
      activeList = [
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
    } else {
      category[active].isSeeAll = true;
      activeList = [
        MovieBar(
          cardTitle: category[active].text,
          searchId: category[active].searchId,
        ),
      ];
    }
    notifyListeners();
  }

  int get categoryCount => category.length;
  void setSeeAll(String text) {
    for (var item in category) {
      if (item.text == text) {
        item.isSeeAll = !item.isSeeAll;
        notifyListeners();
        break;
      }
    }
  }

  bool isSeeAll(String text) {
    for (var item in category) {
      if (item.text == text) {
        return item.isSeeAll;
      }
    }
    return false;
  }

  int get length => category.length;
}
