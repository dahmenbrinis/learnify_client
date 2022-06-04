import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/modules/room/controllers/rooms_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../app/User/auth.dart';
import '../../app/routes/app_pages.dart';
import '../components/my_profile_icon.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const SizedBox(width: 10),
            logo != null
                ? logo!
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SvgPicture.asset(
                      'assets/logo.svg',
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() {
              return Visibility(
                visible: true,
                child: SizedBox(
                  width: 60,
                  child: StaggeredGrid.count(
                    crossAxisCount: 20,
                    children: [
                      const StaggeredGridTile.count(
                        crossAxisCellCount: 5,
                        mainAxisCellCount: 6,
                        child: Icon(Iconsax.medal_star, size: 20),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 15,
                        mainAxisCellCount: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Center(
                            child: Text(
                              Auth.user.points!,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 15,
                        mainAxisCellCount: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: StepProgressIndicator(
                            totalSteps:
                                Auth.user.requiredPoints(Auth.user.rank + 1) -
                                    Auth.user.requiredPoints(Auth.user.rank),
                            currentStep:
                                int.tryParse(Auth.user.points ?? '0')! -
                                    Auth.user.requiredPoints(Auth.user.rank),
                            size: 5,
                            selectedSize: 6,
                            padding: 0,
                            selectedColor: Colors.greenAccent,
                            unselectedColor: Colors.white,
                            roundedEdges: Radius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            // if (isLargeTitle)
            //   GestureDetector(
            //     // padding: EdgeInsets.zero,
            //     onTap: () => Get.offAllNamed(Routes.HOME),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 2),
            //       child: SvgPicture.asset('assets/stats.svg'),
            //     ),
            //   ),

            // Obx(() {
            //   return FadeInImage.assetNetwork(
            //       placeholder: 'assets/loading2.gif',
            //       image:
            //           '${Utils.baseUrl}/api/images/${AuthController.user.profileImageId ?? 3}');
            // }),
            MyProfileName(),
            // GestureDetector(
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            //     child: CustomAvatarImage(
            //       NetImage(id: Auth.user.imageId, alt: Auth.user.name!),
            //     ),
            //   ),
            //   onTap: () {
            //     var controller = Get.find<AuthController>();
            //     controller.logout();
            //   },
            // ),
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
