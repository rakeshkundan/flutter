// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movie/screen/home.dart';
import 'package:movie/screen/home_screen.dart';
import 'package:provider/provider.dart';
import '../components/category_tile.dart';
import '../utilities/category_list.dart';

class CategoryBar extends StatelessWidget {
  final VoidCallback updateList;
  const CategoryBar({super.key, required this.updateList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      height: 35.0,
      child: Consumer<CategoryList>(
        builder: (context, data, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              var item = data.category[index];
              return CategoryTile(
                text: item.text,
                isActive: item.isChecked,
                onPress: () {
                  Provider.of<CategoryList>(context, listen: false)
                      .setActive(index);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Home.id);
                },
              );
            },
            itemCount: CategoryList().categoryCount,
            scrollDirection: Axis.horizontal,
          );
        },
      ),
    );
  }
}
