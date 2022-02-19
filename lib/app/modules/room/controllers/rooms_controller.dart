import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/providers/room_provider.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';

class RoomController extends GetxController {
  final list = RxList.of(<Room>[]);
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
    var x = await Get.find<RoomProvider>().getRooms(page: nextPage.value);
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
}
