// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/components/avatar_image.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static double preferHeight = AppBar().preferredSize.height;
  final String title;
  final double height;
  const CustomAppBar({required this.title, double this.height = 0});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      leadingWidth: 100,
      leading: GestureDetector(
        onTap: () => Get.offNamed(Routes.ROOM),
        child: Row(
          children: [
            SizedBox(width: 10),
            SvgPicture.asset('assets/logo.svg', fit: BoxFit.contain),
          ],
        ),
      ),
      actions: [
        Center(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: SvgPicture.asset('assets/stats.svg'),
              ),
              TextButton(
                child: CustomAvatarImage(
                  image: AssetImage('assets/profile_pic3.jpg'),
                  // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                ),
                onPressed: () => Get.offAllNamed('/login'),
              ),
            ],
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height == 0 ? AppBar().preferredSize.height : height);
}
