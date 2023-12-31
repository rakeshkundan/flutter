import 'package:flutter/material.dart';

class BottomTileInfo {
  final String tileTitle;
  final IconData icon;
  final String id;
  bool isActive;
  BottomTileInfo(
      {this.tileTitle = "Title",
      this.icon = Icons.rectangle,
      this.isActive = false,
      this.id = 'home_screen'});
}
