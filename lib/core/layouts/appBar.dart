import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/controllers/rooms_controller.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import '../components/avatar_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static double preferHeight = AppBar().preferredSize.height;
  final String title;
  final double height;

  final Widget? logo;
  const CustomAppBar({required this.title, this.height = 0, this.logo});

  @override
  AppBar build(BuildContext context) {
    bool isLargeTitle = title.length < 15;
    return AppBar(
      shadowColor: Colors.transparent,
      // backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(fontSize: 22, color: Colors.blue.shade100),
      ),
      leadingWidth: 120,
      leading: RawMaterialButton(
        onPressed: () {
          Get.offAllNamed(Routes.ROOM);
          final controllerRoom = Get.find<RoomController>();
          controllerRoom.paginatedList.init();
          controllerRoom.fetch();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // const SizedBox(width: 10),
            if (logo != null) logo!,
            SvgPicture.asset(
              'assets/logo.svg',
              color: Colors.white,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isLargeTitle)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: SvgPicture.asset('assets/stats.svg'),
              ),
            RawMaterialButton(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: const CustomAvatarImage(
                image: AssetImage('assets/profile_pic3.jpg'),
                // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              ),
              onPressed: () => Get.offAllNamed('/login'),
            ),
          ],
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height == 0 ? AppBar().preferredSize.height : height);
}
