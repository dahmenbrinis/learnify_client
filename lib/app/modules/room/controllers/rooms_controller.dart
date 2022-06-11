import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/modules/room/providers/room_provider.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';
import 'package:learnify_client/core/components/Dialogs.dart';
import 'package:learnify_client/core/pagination.dart';
import '../../../User/user_model.dart';

class RoomController extends GetxController {
  var provider = Get.find<RoomProvider>();
  final _paginatedList = Rx<Paginated<Room>>(Paginated());

  var textController = TextEditingController();

  String search = '';
  set paginatedList(Paginated<Room> value) => _paginatedList.value = value;
  Paginated<Room> get paginatedList => _paginatedList.value;

  User user = Auth.user;

  var isLoading = true.obs;
  var scrollController = ScrollController();
  // double _lastPosition = 0;

  @override
  onInit() {
    init();
    scrollController.addListener(() {
      var pos = scrollController.position;
      if (pos.atEdge && pos.pixels != 0) fetch();
    });
    super.onInit();
  }

  Future fetch() async {
    isLoading.value = true;
    var list = await provider.index('rooms',
        page: paginatedList.next_page, filters: {'search': search});
    paginatedList.addAll(list);
    _paginatedList.refresh();
    search = '';
    isLoading.value = false;
  }

  init() {
    paginatedList.init();
    fetch();
  }

  Future<Room?> join(Room room) async {
    var code = '';
    if (room.visibility == 0) {
      await roomCodeModal((value) => code = value);
      if (code == '') return null;
    }
    var res = await provider.join(room.id!, code);
    if (code.isNotEmpty && (res == null || res.id == null)) {
      errorModal(
          "Error", "the code you entered is incorrect", "Back", Get.back);
    }
    return res;
  }

  Future<Room?> leave(Room room) async {
    var res = await provider.leave(room.id!, room.id.toString());
    return res;
  }

  Future<bool> delete(int roomID) async {
    var res = await provider.destroy('rooms/${roomID}');
    return res;
  }

  void rerender() {
    _paginatedList.refresh();
    print('works');
  }
}
