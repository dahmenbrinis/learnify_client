import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
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
  var roomCode = Rx<String>('');
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

  uploadData(url, data) async {
    var res = await provider.sendRequest(url, "POST", body: FormData(data),
        uploadProgress: (value) {
      if (progress.value * 100 + 10 < value) {
        progress.value = value / 100;
      }
    });
    image.value = null;
    progress.value = 0;
    if (res.body != null && res.body.id != null) {
      res.body.alt2 += 'd';
      Get.back(result: res.body);
    }
  }

  var progress = 0.0.obs;
  Rx<XFile?> image = Rx(null);
  void createRoom() async {
    room = Room(
      name: nameController.text,
      description: descriptionController.text,
      levelId: int.parse(level),
      visibility: isPrivateRoom ? 0 : 1,
    );
    if (room!.visibility == 0) {
      room!.code = roomCode.value;
    }
    var json = room!.toJson();
    if (image.value != null) {
      json['image'] = MultipartFile(
        await image.value!.readAsBytes(),
        filename: image.value!.path,
      );
    }
    await uploadData("rooms", json);
    // room = await provider.create('rooms', room!);
    // if (room != null) {
    //   if (room!.visibility == 0) {
    //     notifySuccess();
    //   } else {  Get.back(result: room);}
    // }
  }

  void updateRoom() async {
    room = Room(
      name: nameController.text,
      description: descriptionController.text,
      levelId: int.parse(level),
      visibility: isPrivateRoom ? 0 : 1,
    );
    if (room!.visibility == 0) {
      room!.code = roomCode.value;
    }
    var json = room!.toJson();
    if (image.value != null) {
      json['image'] = MultipartFile(
        await image.value!.readAsBytes(),
        filename: image.value!.path,
      );
    }
    await uploadData("update_rooms/${old.id}", json);
  }

  String generateCode(Room room) {
    return room.code == null ? getRandomString(6) : room.code!;
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  // notifySuccess() {
  //   Get.defaultDialog(
  //     barrierDismissible: false,
  //     title: 'Created Room ${room!.name} \n',
  //     titlePadding: const EdgeInsets.all(10),
  //     content: MaterialButton(
  //       padding: EdgeInsets.zero,
  //       onPressed: () {},
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(20),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Text(
  //                   'Room Code: ${room!.id.toString().padLeft(4, '0')}',
  //                   style: const TextStyle(fontSize: 20),
  //                 ),
  //                 const Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                   child: Icon(
  //                     Icons.copy,
  //                     color: Colors.blue,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     onConfirm: () {},
  //     confirm: FlatButton(
  //       onPressed: () => Get.back(),
  //       child: const Padding(
  //         padding: EdgeInsets.all(10),
  //         child: Text('back to rooms'),
  //       ),
  //     ),
  //   ).then((value) => Get.back(result: room));
  // }

  void updateFields(Room room) {}
}
