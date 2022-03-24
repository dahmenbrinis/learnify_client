import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/providers/room_provider.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';

class CreateController extends GetxController {
  //TODO: Implement CreateController
  var provider = Get.find<RoomProvider>();
  final loginFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final visibilityController = TextEditingController();
  Room old = Room();
  Room? room = Room();
  final _level = '1'.obs;
  String get level => _level.value;
  set level(value) => _level.value = value;
  final _isPrivateRoom = false.obs;
  bool get isPrivateRoom => _isPrivateRoom.value;
  set isPrivateRoom(bool value) => _isPrivateRoom.value = value;

  @override
  void onReady() {
    if (old.id != null) {
      room = old;
      nameController.text = old.name!;
      descriptionController.text = old.description!;
      level = old.levelId.toString();
      isPrivateRoom = old.visibility == 0;
    }
    super.onReady();
  }

  void createRoom() async {
    room = Room(
      name: nameController.text,
      description: descriptionController.text,
      levelId: int.parse(level),
      visibility: isPrivateRoom ? 0 : 1,
    );
    room = await provider.create('rooms', room!);
    if (room != null) {
      if (room!.visibility == 0) {
        notifySuccess();
      } else {
        Get.back(result: room);
      }
    }
  }

  void updateRoom() async {
    room = Room(
      id: room!.id,
      name: nameController.text,
      description: descriptionController.text,
      levelId: int.parse(level),
      visibility: isPrivateRoom ? 0 : 1,
    );
    room = await provider.update('rooms/${room!.id}', room!);
    if (room != null) Get.back(result: room);
  }

  notifySuccess() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Created Room ${room!.name} \n',
      titlePadding: const EdgeInsets.all(10),
      content: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Room Code: ${room!.id.toString().padLeft(4, '0')}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.copy,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onConfirm: () {},
      confirm: FlatButton(
        onPressed: () => Get.back(),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Text('back to rooms'),
        ),
      ),
    ).then((value) => Get.back(result: room));
  }

  void updateFields(Room room) {}
}
