// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learnify_client/app/routes/app_pages.dart';

class Footer extends StatefulWidget {
  const Footer();

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey,
      fixedColor: Colors.blue.shade700,
      backgroundColor: Colors.grey.shade100,
      selectedFontSize: 18,
      unselectedFontSize: 12,
      showUnselectedLabels: true,
      iconSize: 30,
      currentIndex: index,
      onTap: (int selectedIndex) => setState(() {
        index = selectedIndex;
        if (selectedIndex == 1) Get.toNamed(Routes.ROOM);
        // print(index);
      }),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.group_sharp), label: 'Rooms'),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Questions'),
        BottomNavigationBarItem(icon: Icon(Icons.chair), label: 'Challenges'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
