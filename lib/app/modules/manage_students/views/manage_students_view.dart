// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/core/layouts/appBar.dart';

import '../../../../core/components/avatar_image.dart';
import '../../../../core/components/net_image.dart';
import '../controllers/manage_students_controller.dart';

class ManageStudentsView extends GetView<ManageStudentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Manage Students',
      ),
      body: ListView.builder(
          itemCount: 15,
          controller: controller.scrollController,
          padding: EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) {
            return manageUserCard(context, Auth.user);
          }),
    );
  }

  Widget manageUserCard(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GlassContainer.clearGlass(
        blur: 60,
        height: 130,
        shadowColor: Theme.of(context).primaryColorLight,
        borderColor: Theme.of(context).dividerColor,
        elevation: 10,
        width: double.infinity,
        color: user.id == Auth.user.id
            ? Colors.white60
            : Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(15),
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(5),
        child: StaggeredGrid.count(
          crossAxisCount: 40,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 6,
              mainAxisCellCount: 7,
              child: Column(
                children: [
                  CustomAvatarImage(
                    NetImage(
                      id: user.imageId,
                      alt: user.name!,
                    ),
                  ),
                  Center(child: Text(user.name!)),
                ],
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("questions: ${user.points!}"),
                    Text("answers: ${user.points!}"),
                    // Text("Points: ${user.points!}"),
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
                      "Points : ${user.points!} point",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Member since : 20-05-2022",
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            Iconsax.profile_delete,
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
                    SizedBox(width: 30),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            Iconsax.profile_delete,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Center(
                          child: Text(
                            "commend",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
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
