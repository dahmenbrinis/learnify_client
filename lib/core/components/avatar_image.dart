import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class CustomAvatarImage extends StatelessWidget {
  Widget? image;
  final EdgeInsetsGeometry padding;

  var isTeacher = false;

  CustomAvatarImage(this.image,
      {this.padding = EdgeInsets.zero, this.isTeacher = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Badge(
        padding: EdgeInsets.zero,
        position: BadgePosition.bottomEnd(bottom: -2, end: -10),
        badgeColor: Colors.green,
        showBadge: isTeacher,
        badgeContent: Container(
          padding: EdgeInsets.all(3),
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue,
          ),
          child: Image.asset(
            'assets/teacher_icon.png',
            color: Colors.white,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: const Color(0x800090FF),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: image,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
