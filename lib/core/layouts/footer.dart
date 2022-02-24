// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
      fixedColor: Colors.blueAccent.shade400,
      backgroundColor: Colors.grey.shade100,
      selectedFontSize: 18,
      unselectedFontSize: 12,
      showUnselectedLabels: true,
      iconSize: 30,
      currentIndex: index,
      onTap: (int selectedIndex) => setState(() {
        index = selectedIndex;
        if (selectedIndex == 1) Get.toNamed(Routes.ROOM);
      }),
      items: [
        BottomNavigationBarItem(
            icon: Icon(Iconsax.home_hashtag), label: 'Rooms'),
        BottomNavigationBarItem(
            icon: Icon(Iconsax.message_programming), label: 'Questions'),
        BottomNavigationBarItem(icon: Icon(Iconsax.award), label: 'Challenges'),
        BottomNavigationBarItem(icon: Icon(Iconsax.setting), label: 'Settings'),
      ],
    );
  }
}
