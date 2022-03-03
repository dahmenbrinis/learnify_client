import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';
import 'package:learnify_client/app/modules/room/controllers/rooms_controller.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/components/net_image.dart';
import 'package:learnify_client/core/model.dart';
import '../../app/User/auth.dart';
import '../components/avatar_image.dart';
import '../utils.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
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
              GestureDetector(
                // padding: EdgeInsets.zero,
                onTap: () => Get.offAllNamed(Routes.HOME),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: SvgPicture.asset('assets/stats.svg'),
                ),
              ),
            // Obx(() {
            //   return FadeInImage.assetNetwork(
            //       placeholder: 'assets/loading2.gif',
            //       image:
            //           '${Utils.baseUrl}/api/images/${AuthController.user.profileImageId ?? 3}');
            // }),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: CustomAvatarImage(
                  NetImage(id: Auth.user.imageId, alt: Auth.user.name!),
                ),
              ),
              onTap: () => Get.offAllNamed('/login'),
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
