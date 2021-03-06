import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/layouts/appBar.dart';
import 'package:learnify_client/core/layouts/footer.dart';

import '../../../../core/components/avatar_image.dart';
import '../../../../core/components/net_image.dart';
import '../controllers/leaderboard_controller.dart';

class LeaderboardView extends GetView<LeaderboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '${controller.room.name} LeaderBoard',
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
                            color: controller.users.data[index + 3].payee.id ==
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
                                      Get.toNamed(Routes.PROFILE,
                                          arguments: controller
                                              .users.data[index + 3].payee);
                                    },
                                    child: CustomAvatarImage(
                                      NetImage(
                                        id: controller.users.data[index + 3]
                                            .payee.imageId,
                                        alt: controller
                                            .users.data[index + 3].payee.alt,
                                        minSize: 200,
                                      ),
                                    ),
                                  ),
                                ),
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 20,
                                  mainAxisCellCount: 6,
                                  child: Center(
                                    child: Text(controller
                                        .users.data[index + 3].payee.name!),
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
                      150.0,
                    ),
                  ),
                ),
              ),
              Obx(() {
                print(controller.isLoading);
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
                                                controller.users.data[1].payee);
                                      },
                                      child: CustomAvatarImage(
                                        NetImage(
                                          id: controller
                                              .users.data[1].payee.imageId,
                                          alt: controller
                                              .users.data[1].payee.alt,
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
                                      child: CustomAvatarImage(
                                        NetImage(
                                          id: controller
                                              .users.data[0].payee.imageId,
                                          alt: controller
                                              .users.data[0].payee.alt,
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
                                                controller.users.data[2].payee);
                                      },
                                      child: CustomAvatarImage(
                                        NetImage(
                                          id: controller
                                              .users.data[2].payee.imageId,
                                          alt: controller
                                              .users.data[2].payee.alt,
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
                                    ? controller.users.data[1].payee.name!
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
                                    ? controller.users.data[2].payee.name!
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
                                    ? controller.users.data[0].payee.name!
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
