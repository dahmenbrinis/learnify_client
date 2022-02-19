// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      selectedFontSize: 16,
      unselectedFontSize: 12,
      showUnselectedLabels: true,
      iconSize: 35,
      currentIndex: index,
      onTap: (int selectedIndex) => setState(() {
        index = selectedIndex;
        // print(index);
      }),
      items: [
        // BottomNavigationBarItem(
        //     icon: SvgPicture.asset(
        //       'assets/my_rooms.svg',
        //     ),
        //     label: 'MyRooms'),
        BottomNavigationBarItem(icon: Icon(Icons.group_sharp), label: 'Rooms'),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Questions'),
        BottomNavigationBarItem(icon: Icon(Icons.chair), label: 'Challenges'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
