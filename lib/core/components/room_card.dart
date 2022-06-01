// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/modules/room/controllers/rooms_controller.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';
import 'package:learnify_client/app/modules/room/views/update_view.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/components/net_image.dart';
import 'package:learnify_client/core/utils.dart';

import '../../app/User/auth.dart';

class RoomCard extends StatelessWidget {
  final controller = Get.find<RoomController>();
  final _room = Rx<Room>(Room());
  final Room data;

  Room get room => _room.value;

  set room(Room value) => _room.value = value;

  final _isOpen = false.obs;
  final refresh = false.obs;

  bool get isOpen => _isOpen.value;

  set isOpen(value) => _isOpen.value = value;

  RoomCard(this.data);

  @override
  Widget build(BuildContext context) {
    room = data;
    return RawMaterialButton(
      onPressed: () => isOpen = !isOpen,
      onLongPress: () {},
      child: Container(
        // duration: Duration(seconds: 1),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xe2ffffff),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Column(
          children: [
            ///------- head ---------
            StaggeredGrid.count(
              // crossAxisAlignment: CrossAxisAlignment.start,
              crossAxisCount: 20,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 4,
                  child: NetImage(id: room.imageId, alt: room.name!),
                ),
                StaggeredGridTile.fit(
                  crossAxisCellCount: 13,
                  child: Text(
                    room.name!.capitalize!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 3,
                  mainAxisCellCount: 5,
                  // mainAxisExtent: 100,
                  child: Obx(() {
                    return Visibility(
                      visible: room.permissions!.canView,
                      child: GestureDetector(
                        onTap: () {
                          if (room.permissions!.canView)
                            Get.toNamed(Routes.QUESTIONS, arguments: room);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColorLight
                                .withAlpha(50),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: RotatedBox(
                              quarterTurns: 0,
                              child: Icon(Iconsax.arrow_circle_right,
                                  color: Colors.blue)),
                        ),
                      ),
                    );
                  }),
                ),
                StaggeredGridTile.fit(
                  crossAxisCellCount: 13,
                  // mainAxisCellCount: 4,
                  child: Text(room.description!,
                      style: TextStyle(color: Colors.black45)),
                ),
              ],
            ),

            ///------- body ---------
            Obx(() {
              return Visibility(
                  visible: isOpen,
                  child: Divider(thickness: 1, color: Colors.grey));
            }),

            Obx(() {
              return AnimatedSize(
                duration: Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                child: Visibility(
                  visible: isOpen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 5,
                      children: [
                        if (room.permissions!.canAsk)
                          MaterialButton(
                            onPressed: () => Get.toNamed(Routes.CREATE_QUESTION,
                                arguments: room),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Iconsax.message_add,
                                    color: Color(0xff00d1ff)),
                                SizedBox(height: 10),
                                Text(
                                  'Ask Question',
                                  style: TextStyle(color: Color(0xff00d1ff)),
                                )
                              ],
                            ),
                          ),
                        if (room.permissions!.canUpdate)
                          MaterialButton(
                            onPressed: () async {
                              await Get.to(() => UpdateView(room: room))
                                  ?.then((value) {
                                if (value != null) {
                                  room = value;
                                }
                                refresh.value = !refresh.value;
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Iconsax.edit, color: Colors.blue.shade700),
                                SizedBox(height: 10),
                                Text(
                                  'Edit Room',
                                  style: TextStyle(color: Colors.blue.shade700),
                                )
                              ],
                            ),
                          ),
                        if (room.permissions!.canDelete)
                          RawMaterialButton(
                            onPressed: () async {
                              bool deleted = await controller.delete(room.id!);
                              if (deleted) {
                                controller.paginatedList.data.remove(room);
                                controller.rerender();
                              }
                              _room.refresh();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Iconsax.box_remove,
                                    color: Color(0xffE86575)),
                                SizedBox(height: 10),
                                Text(
                                  'Remove Room',
                                  style: TextStyle(color: Color(0xffE86575)),
                                )
                              ],
                            ),
                          ),
                        if (room.permissions!.canView)
                          MaterialButton(
                            onPressed: () {
                              Get.toNamed(Routes.LEADERBOARD, arguments: room);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Iconsax.cup, color: Color(0xffF3B412)),
                                SizedBox(height: 10),
                                Text(
                                  'Leaderboard',
                                  style: TextStyle(color: Color(0xffF3B412)),
                                )
                              ],
                            ),
                          ),
                        if (!room.permissions!.canDelete &&
                            room.permissions!.canView)
                          RawMaterialButton(
                            onPressed: () async {
                              Room? res = await controller.leave(room);
                              if (res!.id != null) {
                                room = res;
                                // controller.refresh();
                              }
                              _room.refresh();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Iconsax.logout, color: Color(0xffE86575)),
                                SizedBox(height: 10),
                                Text(
                                  'Leave Room',
                                  style: TextStyle(color: Color(0xffE86575)),
                                )
                              ],
                            ),
                          ),
                        if (!room.permissions!.canView)
                          MaterialButton(
                            onPressed: () async {
                              Room? res = await controller.join(room);
                              if (res!.id != null) {
                                room = res;
                                // controller.refresh();
                              }
                              _room.refresh();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  size: 30,
                                  color: Colors.greenAccent.shade700,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Join Room',
                                  style: TextStyle(
                                      color: Colors.greenAccent.shade700),
                                )
                              ],
                            ),
                          ),
                        if (room.creatorId == Auth.user.id)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Iconsax.profile_2user,
                                  color: Colors.indigoAccent),
                              SizedBox(height: 10),
                              Text(
                                'Manage Students',
                                style: TextStyle(color: Colors.indigoAccent),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            ///------- footer ---------
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: StaggeredGrid.count(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                children: [
                  Text(room.answersCount.toString() + " New Answers",
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.center),
                  Text(room.questionsCount.toString() + " Questions",
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.center),
                  Text(room.userCount.toString() + " Poeple",
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
