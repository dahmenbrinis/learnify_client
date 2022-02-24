import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/controllers/rooms_controller.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import '../components/avatar_image.dart';

class SecondAppBar extends StatelessWidget implements PreferredSizeWidget {
  static double preferHeight = AppBar().preferredSize.height;
  final String title;
  final double height;

  final Widget? logo;
  const SecondAppBar(
      {Key? key, required this.title, this.height = 0, this.logo})
      : super(key: key);

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
      leadingWidth: 100,
      leading: logo ??
          RawMaterialButton(
            onPressed: () {
              Get.offAllNamed(Routes.ROOM);
              final controllerRoom = Get.find<RoomController>();
              controllerRoom.paginatedList.init();
              controllerRoom.fetch();
            },
            child: SvgPicture.asset('assets/logo.svg', color: Colors.white),
          ),
      actions: [
        Center(
          child: Row(
            children: [
              RawMaterialButton(
                padding: EdgeInsets.all(4),
                child: const CustomAvatarImage(
                  image: AssetImage('assets/profile_pic3.jpg'),
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
