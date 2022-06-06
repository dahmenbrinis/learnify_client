import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/routes/app_pages.dart';

import '../../app/User/AuthController.dart';
import '../../app/User/auth.dart';
import 'avatar_image.dart';
import 'net_image.dart';

class MyProfileName extends StatelessWidget {
  const MyProfileName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: CustomAvatarImage(
            NetImage(id: Auth.user.imageId, alt: Auth.user.alt),
          ),
        ),
        openWithLongPress: true,
        customItemsIndexes: const [2],
        customItemsHeight: 8,
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem);
        },
        itemHeight: 48,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white.withAlpha(220),
        ),
        dropdownElevation: 4,
        offset: const Offset(40, -4),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [notifications, profile];
  static const List<MenuItem> secondItems = [logout];

  static const notifications =
      MenuItem(text: 'Notifications', icon: Iconsax.notification);
  static const profile = MenuItem(text: 'My Profile', icon: Iconsax.user);
  static const logout = MenuItem(text: 'Logout', icon: Iconsax.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: Colors.blueAccent,
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.notifications:
        Get.toNamed(Routes.NOTIFICATIONS);
        break;
      case MenuItems.profile:
        Get.toNamed(Routes.PROFILE, arguments: Auth.user);
        break;
      case MenuItems.logout:
        var controller = Get.find<AuthController>();
        controller.logout();
        break;
    }
  }
}
