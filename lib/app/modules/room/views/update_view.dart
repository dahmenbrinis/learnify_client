import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnify_client/app/modules/room/controllers/create_controller.dart';
import 'package:learnify_client/core/components/input_filed.dart';

import '../room_model.dart';

class UpdateView extends GetView<CreateController> {
  final Room room;

  const UpdateView({required this.room});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CreateController>(() => CreateController());
    controller.old = room;
    var code = controller.generateCode(room);
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
            child: SingleChildScrollView(
              child: Container(
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
                      Container(
                        child: Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Upload Image:',
                                  style: TextStyle(fontSize: 20)),
                              TextButton(
                                onPressed: () async {
                                  final _picker = ImagePicker();
                                  controller.image.value =
                                      await _picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 50,
                                  );
                                },
                                child: const Text("select an image"),
                              ),
                              if (controller.image.value != null)
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.file(
                                      File(controller.image.value!.path),
                                      width: Get.width / 2,
                                      height: Get.width / 2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                            ],
                          );
                        }),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Public",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
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
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.pink),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Visibility(
                                  visible: controller.isPrivateRoom,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Room code: ${code}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        tooltip:
                                            "the code is saved to your clipboard",
                                        onPressed: () {},
                                        icon: Icon(
                                          Iconsax.clipboard,
                                          color: Colors.blue,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ))
                            ]);
                      }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Text(
                              "Room Level:",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Obx(() {
                            return Container(
                              color: Colors.white,
                              // decoration:BoxDecoration(shape: BorderRadius.circular(0)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                controller.roomCode.value = code;
                controller.updateRoom();
              },
            ),
          ),
        ],
      ),
    );
  }
}
