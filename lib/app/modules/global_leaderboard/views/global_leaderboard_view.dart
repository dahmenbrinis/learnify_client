import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/components/avatar_image.dart';
import '../../../../core/components/net_image.dart';
import '../../../../core/layouts/appBar.dart';
import '../../../../core/layouts/footer.dart';
import '../../../User/auth.dart';
import '../../../routes/app_pages.dart';
import '../controllers/global_leaderboard_controller.dart';

class GlobalLeaderboardView extends GetView<GlobalLeaderboardController> {
  @override
  Widget build(BuildContext context) {
    Footer.index = 2;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Global LeaderBoard',
        logo: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(Iconsax.direct_left5),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              /// rest of leader board ///
              Container(
                padding: EdgeInsets.only(top: 140),
                height: MediaQuery.of(context).size.height - 160,
                child: Obx(() {
                  print(controller.isLoading);
                  return ListView.builder(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.only(top: 150),
                    itemCount: max(controller.users.length - 3, 0),
                    itemBuilder: (context, index) {
                      // return Text('fasf');
                      return Column(
                        children: [
                          const SizedBox(height: 5),
                          GlassContainer.clearGlass(
                            blur: 60,
                            height: 70,
                            shadowColor: Theme.of(context).primaryColorLight,
                            borderColor: Theme.of(context).dividerColor,
                            elevation: 10,
                            width: double.infinity,
                            color: controller.users.data[index + 3].id ==
                                    Auth.user.id
                                ? Theme.of(context).primaryColorLight
                                : null,
                            borderRadius: BorderRadius.circular(15),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(5),
                            child: StaggeredGrid.count(
                              crossAxisCount: 40,
                              children: [
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 4,
                                  mainAxisCellCount: 6,
                                  child: Center(
                                    child: Text(
                                      '${index + 4}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 6,
                                  mainAxisCellCount: 6,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.PROFILE,
                                        arguments:
                                            controller.users.data[index + 3],
                                      );
                                    },
                                    child: CustomAvatarImage(
                                      NetImage(
                                        id: controller
                                            .users.data[index + 3].imageId,
                                        alt: controller
                                            .users.data[index + 3].alt,
                                      ),
                                    ),
                                  ),
                                ),
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 20,
                                  mainAxisCellCount: 6,
                                  child: Center(
                                    child: Text(
                                        controller.users.data[index + 3].name!),
                                  ),
                                ),
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 10,
                                  mainAxisCellCount: 6,
                                  child: Center(
                                    child: Text(controller
                                        .users.data[index + 3].points!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (index + 1 == controller.users.data.length &&
                              controller.isLoading &&
                              controller.users.has_next)
                            const Center(child: RefreshProgressIndicator()),
                          if (index + 1 == controller.users.length)
                            const SizedBox(height: 50)
                        ],
                      );
                    },
                  );
                }),
              ),

              ///top 3 ///
              Container(
                height: 280.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 40.0,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width - 150,
                      100,
                    ),
                  ),
                ),
              ),
              Obx(() {
                controller.isLoading;
                return Container(
                  height: 260,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: StaggeredGrid.count(
                      crossAxisCount: 40,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        /// crown badges ///
                        StaggeredGridTile.count(
                          crossAxisCellCount: 40,
                          mainAxisCellCount: 6,
                          child: StaggeredGrid.count(
                            crossAxisCount: 40,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: [
                              StaggeredGridTile.fit(
                                crossAxisCellCount: 12,
                                child: Icon(
                                  Iconsax.medal_star5,
                                  size: 50,
                                  color: Colors.blueGrey.shade200,
                                ),
                              ),
                              StaggeredGridTile.fit(
                                crossAxisCellCount: 16,
                                child: Icon(
                                  Iconsax.crown5,
                                  size: 50,
                                  color: Colors.orange.shade600,
                                ),
                              ),
                              const StaggeredGridTile.fit(
                                crossAxisCellCount: 12,
                                child: Icon(
                                  Iconsax.crown_15,
                                  size: 50,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// top 3 leaders ///
                        StaggeredGridTile.count(
                          crossAxisCellCount: 12,
                          mainAxisCellCount: 12,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).backgroundColor,
                                      spreadRadius: 5,
                                      blurRadius: 10),
                                ]),
                            child: controller.users.length > 1
                                ? Badge(
                                    stackFit: StackFit.expand,
                                    padding: EdgeInsets.all(10),
                                    badgeColor: Colors.yellow.shade800,
                                    badgeContent: const Text(
                                      '2nd',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.PROFILE,
                                            arguments:
                                                controller.users.data[1]);
                                      },
                                      child: CustomAvatarImage(
                                        NetImage(
                                          id: controller.users.data[1].imageId,
                                          alt: controller.users.data[1].alt,
                                        ),
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Iconsax.forbidden,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 16,
                          mainAxisCellCount: 16,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).backgroundColor,
                                      spreadRadius: 5,
                                      blurRadius: 10),
                                  BoxShadow(
                                      color: Theme.of(context).backgroundColor,
                                      spreadRadius: 5,
                                      blurRadius: 10),
                                ]),
                            child: controller.users.data.isNotEmpty
                                ? Badge(
                                    stackFit: StackFit.expand,
                                    padding: EdgeInsets.all(10),
                                    badgeColor: Colors.yellow.shade800,
                                    badgeContent: const Text(
                                      '1st',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.PROFILE,
                                            arguments:
                                                controller.users.data[0]);
                                      },
                                      child: CustomAvatarImage(
                                        NetImage(
                                          id: controller.users.data[0].imageId,
                                          alt: controller.users.data[0].alt,
                                        ),
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Iconsax.forbidden,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 12,
                          mainAxisCellCount: 12,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).backgroundColor,
                                      spreadRadius: 5,
                                      blurRadius: 10),
                                ]),
                            child: controller.users.length > 2
                                ? Badge(
                                    stackFit: StackFit.expand,
                                    padding: EdgeInsets.all(10),
                                    badgeColor: Colors.yellow.shade800,
                                    badgeContent: const Text(
                                      '3rd',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.PROFILE,
                                            arguments:
                                                controller.users.data[1]);
                                      },
                                      child: CustomAvatarImage(
                                        NetImage(
                                          id: controller.users.data[2].imageId,
                                          alt: controller.users.data[2].alt,
                                        ),
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Iconsax.forbidden,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                          ),
                        ),

                        /// leader names ///
                        StaggeredGridTile.count(
                          crossAxisCellCount: 12,
                          mainAxisCellCount: 10,
                          child: Column(
                            children: [
                              Text(
                                controller.users.length > 1
                                    ? controller.users.data[1].name!
                                    : "Not Claimed",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                controller.users.length > 1
                                    ? "${controller.users.data[1].points} Pts"
                                    : " ",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        StaggeredGridTile.fit(
                          crossAxisCellCount: 12,
                          child: Column(
                            children: [
                              Text(
                                controller.users.length > 2
                                    ? controller.users.data[2].name!
                                    : "Not Claimed",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                controller.users.length > 2
                                    ? "${controller.users.data[2].points} Pts"
                                    : " ",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        // StaggeredGridTile.fit(
                        //   crossAxisCellCount: 12,
                        //   child: Text(" "),
                        // ),
                        StaggeredGridTile.fit(
                          crossAxisCellCount: 16,
                          child: Column(
                            children: [
                              Text(
                                controller.users.data.isNotEmpty
                                    ? controller.users.data[0].name!
                                    : "Not Claimed",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                controller.users.data.isNotEmpty
                                    ? "${controller.users.data[0].points} Pts"
                                    : " ",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
