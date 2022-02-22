import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';
import 'package:learnify_client/app/modules/room/providers/room_provider.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';
import '../../../User/user_model.dart';

class RoomController extends GetxController {
  var provider = Get.find<RoomProvider>();
  final list = RxList.of(<Room>[]);
  User user = Get.find<AuthController>().user;
  var nextPage = 1.obs;
  var isLoading = true.obs;
  // set list(value) => list.value = value;
  var scrollController = ScrollController();
  // double _lastPosition = 0;

  @override
  onInit() {
    addToList();
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) addToList();
      // _lastPosition = scrollController.position.pixels;
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future fetch() async {
    isLoading.value = true;
    var x = await provider.index('room', page: nextPage.value);
    isLoading.value = false;
    return x;
  }

  addToList() {
    fetch().then((value) {
      if (value.length == 0) isLoading.value = false;
      nextPage++;
      list.addAll(value);
    });
  }

  void refreshList() {
    list.clear();
    nextPage.value = 1;
    addToList();
  }

  Future<Room?> join(Room room) async {
    return await provider.join(room.id!, room.id.toString());
  }
}
