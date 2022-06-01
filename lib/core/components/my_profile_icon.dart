import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
            NetImage(id: Auth.user.imageId, alt: Auth.user.name!),
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
        onChanged: (value) {},
        itemHeight: 48,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white70,
        ),
        dropdownElevation: 8,
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
      MenuItem(text: 'My profile', icon: Icons.favorite);
  static const profile = MenuItem(text: 'My Profile', icon: Icons.download);
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
        //Do something
        break;
      case MenuItems.profile:
        //Do something
        break;
      case MenuItems.logout:
        //Do something
        break;
    }
  }
}
