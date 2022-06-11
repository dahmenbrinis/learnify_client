// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/core/components/Dialogs.dart';
import 'package:learnify_client/core/layouts/appBar.dart';
import 'package:learnify_client/core/layouts/background_widget.dart';

import '../../../../core/components/avatar_image.dart';
import '../../../../core/components/net_image.dart';
import '../../../../core/layouts/Background2.dart';
import '../../../routes/app_pages.dart';
import '../controllers/manage_students_controller.dart';
import 'package:intl/intl.dart';

class ManageStudentsView extends GetView<ManageStudentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Manage Users',
      ),
      body: BackgroundWidget2(
        child: Obx(() {
          return Visibility(
            visible: !controller.isLoading,
            child: ListView.builder(
                itemCount: controller.users.length,
                controller: controller.scrollController,
                padding: EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  return manageUserCard(context, controller.users.data[index]);
                }),
          );
        }),
      ),
    );
  }

  Widget manageUserCard(BuildContext context, User user) {
    var points = controller.getPoints(user);
    var date = DateTime.parse(user.createdAt!);
    final DateFormat formatter = DateFormat('yMMM');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GlassContainer.clearGlass(
        blur: 60,
        height: 130,
        shadowColor: Theme.of(context).primaryColorLight,
        borderColor: Theme.of(context).dividerColor,
        elevation: 10,
        width: double.infinity,
        color: Colors.white60,
        borderRadius: BorderRadius.circular(15),
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(5),
        child: StaggeredGrid.count(
          crossAxisCount: 40,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 9,
              mainAxisCellCount: 7,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE, arguments: user);
                },
                child: Column(
                  children: [
                    CustomAvatarImage(
                      NetImage(
                        id: user.imageId,
                        alt: user.alt,
                      ),
                      isTeacher: user.type == 0,
                    ),
                    SizedBox(height: 2),
                    Center(
                        child: Text(
                      user.name!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 4,
              child: Container(),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 26,
              mainAxisCellCount: 7,
              child: Center(
                child: StaggeredGrid.count(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisCount: 3,
                  children: [
                    Text("questions: ${user.questions_count}"),
                    Text("answers: ${user.comments_count}"),
                    Text(user.type == 0 ? "" : "All Points: ${user.points!}"),
                  ],
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 20,
              mainAxisCellCount: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      user.type == 0
                          ? ""
                          : "Points in current room : $points point",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Member since : ${formatter.format(date)}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 20,
              mainAxisCellCount: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (user.type == 0) return;
                        controller.commend(user.id!);
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Iconsax.like_shapes,
                              color: user.type == 0 || user.isRecommended
                                  ? Colors.transparent
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                          Center(
                            child: Text(
                              "commend",
                              style: TextStyle(
                                color: user.type == 0 || user.isRecommended
                                    ? Colors.transparent
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        confirmationModal(
                          "Kick ${user.name} ?",
                          "are you sure that you want to kick the user ${user.name}",
                          "return",
                          "kick user",
                          Get.back,
                          () {
                            controller.kick(user.id!);
                            Get.back();
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Iconsax.forbidden_2,
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                          Center(
                              child: Text(
                            "kick",
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
