import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/controllers/create_controller.dart';
import 'package:learnify_client/components/input_filed.dart';

import '../room_model.dart';

class UpdateView extends GetView<CreateController> {
  final Room room;

  const UpdateView({required Room this.room});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CreateController>(() => CreateController());
    controller.old = room;
    // controller.updateFields(room);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('New Room'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: StaggeredGrid.count(
                crossAxisCount: 1,
                mainAxisSpacing: 20,
                children: [
                  InputField(
                    inputText: const Text(
                      'Room Name:',
                      style: TextStyle(fontSize: 20),
                    ),
                    inputController: controller.nameController,
                  ),
                  InputField(
                    inputText: const Text(
                      'Description:',
                      style: TextStyle(fontSize: 20),
                    ),
                    inputController: controller.descriptionController,
                    lines: 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Upload Image:',
                          style: TextStyle(fontSize: 20)),
                      TextButton(
                        onPressed: () {
                          print('');
                        },
                        child: const Text("select an image"),
                      ),
                    ],
                  ),
                  Obx(() {
                    return StaggeredGrid.count(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        children: [
                          const StaggeredGridTile.fit(
                            crossAxisCellCount: 2,
                            child: Text(
                              "Visibility:",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "Public",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                              Switch(
                                activeColor: Colors.pink,
                                inactiveThumbColor: Colors.blue,
                                inactiveTrackColor: Colors.blue.shade700,
                                value: controller.isPrivateRoom,
                                onChanged: (value) {
                                  controller.isPrivateRoom = value;
                                },
                              ),
                              const Text(
                                "Private",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.pink),
                              ),
                            ],
                          ),
                          if (controller.isPrivateRoom && false)
                            MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Room Code: 45324',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.copy,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          // InputField(inputText: Text(""))
                        ]);
                  }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text(
                          "Room Level:",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Obx(() {
                        return Container(
                          color: Colors.white,
                          // decoration:BoxDecoration(shape: BorderRadius.circular(0)),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButtonFormField<String>(
                            value: controller.level,
                            onChanged: (value) => controller.level = value,
                            items: const [
                              DropdownMenuItem(
                                value: '1',
                                child: Text('Primary'),
                              ),
                              DropdownMenuItem(
                                value: '2',
                                child: Text('Secondary'),
                              ),
                              DropdownMenuItem(
                                value: '3',
                                child: Text('University'),
                              ),
                              DropdownMenuItem(
                                value: '4',
                                child: Text('Professional'),
                              )
                            ],
                            // decoration: InputDecoration(fillColor: Colors.red),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                child: Text('Update Room', style: TextStyle(fontSize: 25)),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 20),
                minimumSize: Size(MediaQuery.of(context).size.width / 3, 0),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onPressed: () {
                controller.updateRoom();
              },
            ),
          ),
        ],
      ),
    );
  }
}
