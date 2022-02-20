// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';
import 'package:learnify_client/app/modules/room/views/create_view.dart';
import 'package:learnify_client/app/modules/room/views/update_view.dart';
import 'package:learnify_client/utils.dart';

import '../app/modules/room/controllers/rooms_controller.dart';

class RoomCard extends StatelessWidget {
  final Rx<Room> _room;

  Room get room => _room.value;
  set room(Room value) => _room.value = value;
  final Image image;

  final _isOpen = false.obs;
  final refresh = false.obs;

  bool get isOpen => _isOpen.value;

  set isOpen(value) => _isOpen.value = value;

  RoomCard(this._room, {required this.image});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Container(height: refresh.value ? 0 : 1);
      return RawMaterialButton(
        // padding: EdgeInsets.all(0),
        // onPressed: () => Get.toNamed('question', parameters: {"id": "0"}),
        onLongPress: () => isOpen = !isOpen,
        onPressed: () {},
        child: Container(
          // color: Colors.blue,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10)],
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
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/math.png',
                          image:
                              '${Utils.baseUrl}/api/${room.imageName ?? "s"}')),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 14,
                    child: Text(room.name!.capitalize!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: GestureDetector(
                      onTap: () => isOpen = !isOpen,
                      child: Icon(Icons.more_vert, color: Colors.blue),
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 14,
                    mainAxisCellCount: 4,
                    child: Text(room.description!,
                        style: TextStyle(color: Colors.black45)),
                  ),
                ],
              ),

              ///------- body ---------

              if (isOpen) Divider(color: Colors.black),
              if (isOpen)
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      children: [
                        if (room.permissions!.canAsk)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/question_svgrepo_com.svg',
                                width: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Ask Question',
                                style: TextStyle(color: Color(0xff00d1ff)),
                              )
                            ],
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
                                // print(controller.list.length);
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/edit__list.svg',
                                  width: 30,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Edit Room',
                                  style: TextStyle(color: Colors.blue.shade700),
                                )
                              ],
                            ),
                          ),
                        if (room.permissions!.canDelete)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/file_remove.svg',
                                width: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Remove Room',
                                style: TextStyle(color: Color(0xffE86575)),
                              )
                            ],
                          ),
                        if (room.permissions!.canView)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/leaderboard.svg',
                                width: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Leaderboard',
                                style: TextStyle(color: Color(0xffF3B412)),
                              )
                            ],
                          ),
                        if (!room.permissions!.canView)
                          MaterialButton(
                            onPressed: () async {
                              await Get.find<RoomController>()
                                  .join(room)
                                  .then((value) {
                                if (value != null) {
                                  room = value;
                                }
                                _room.refresh();
                                refresh.value = !refresh.value;
                              });
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
                        if (room.creatorId ==
                            Get.find<AuthController>().user.id)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/managestudents.svg',
                                width: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Manage Student',
                                style: TextStyle(color: Colors.indigoAccent),
                              )
                            ],
                          ),
                      ],
                    ),
                  );
                }),

              ///------- footer ---------
              Divider(color: Colors.black),

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
                    // Flexible(flex: 1, child: widget.image),
                    // SizedBox(width: 10),
                    // Flexible(flex: 9, child: Text(widget.description)),
                    // SizedBox(width: 10),
                    // Flexible(
                    //   flex: 1,
                    //   child: Icon(Icons.more_vert, color: Colors.blue),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
