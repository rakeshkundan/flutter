// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:movie/screen/loading_screen.dart';
import 'package:movie/utilities/bottom_tile_info.dart';
import 'package:movie/screen/home_screen.dart';
import 'package:movie/screen/circle_screen.dart';
import 'package:movie/screen/library_screen.dart';
import 'package:movie/screen/message_screen.dart';
import 'package:movie/screen/profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StateData extends ChangeNotifier {
  Map<String, bool> profileEdit = {
    'Name': false,
    'About': false,
    'Phone': false,
  };
  void setEdit(String key) {
    profileEdit[key] = !profileEdit[key]!;
    notifyListeners();
  }

  bool getEdit(String key) {
    return profileEdit[key]!;
  }

  int reviewCount = 0;
  void reviewCountUpdate(int x) {
    reviewCount = x;
    notifyListeners();
  }

  int active = 0;
  List<BottomTileInfo> navInfo = [
    BottomTileInfo(
      tileTitle: 'Home',
      icon: Icons.home_outlined,
      isActive: true,
      id: HomeScreen.id,
    ),
    BottomTileInfo(
      tileTitle: 'Circles',
      icon: FontAwesomeIcons.circle,
      isActive: false,
      id: CircleScreen.id,
    ),
    BottomTileInfo(
      tileTitle: 'Library',
      icon: FontAwesomeIcons.clapperboard,
      isActive: false,
      id: LibraryScreen.id,
    ),
    BottomTileInfo(
      tileTitle: 'Messages',
      icon: FontAwesomeIcons.message,
      isActive: false,
      id: LoadingScreen.id,
    ),
    BottomTileInfo(
      tileTitle: 'Profile',
      icon: FontAwesomeIcons.user,
      isActive: false,
      id: ProfileScreen.id,
    ),
  ];

  void setActive(int i) {
    navInfo[active].isActive = false;
    navInfo[i].isActive = true;
    active = i;
    notifyListeners();
  }
}
