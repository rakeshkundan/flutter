// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/data/state_data.dart';
import 'package:movie/utilities/bottom_tile_info.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});
  List<BottomNavTile> navBuilder(List<BottomTileInfo> navInfo) {
    List<BottomNavTile> list = [];
    for (int i = 0; i < navInfo.length; i++) {
      list.add(
        BottomNavTile(
          icon: navInfo[i].icon,
          name: navInfo[i].tileTitle,
          isActive: navInfo[i].isActive,
          index: i,
          id: navInfo[i].id,
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 29.0, top: 0.0, right: 29.0),
      height: 75.0,
      decoration: BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navBuilder(Provider.of<StateData>(context).navInfo),
      ),
    );
  }
}

class BottomNavTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final bool isActive;
  final int index;
  final String id;
  const BottomNavTile({
    super.key,
    this.icon = Icons.rectangle_outlined,
    this.name = 'Text',
    this.isActive = false,
    required this.index,
    this.id = 'home_screen',
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        // margin: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
        decoration: BoxDecoration(
          border: Border(
            top: isActive
                ? BorderSide(
                    color: kIconColor,
                    width: 2.0,
                  )
                : BorderSide(
                    width: 2.0,
                    color: Color(0x00000000),
                  ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Provider.of<StateData>(context, listen: false).setActive(index);
                // Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  id,
                );
              },
              child: Icon(
                icon,
                size: 30.0,
                color: isActive ? kIconColor : kInactiveTextColor,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                color: isActive ? kIconColor : kInactiveTextColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
