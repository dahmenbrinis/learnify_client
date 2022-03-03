import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/modules/room/providers/room_provider.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';
import 'package:learnify_client/core/pagination.dart';
import '../../../User/user_model.dart';

class RoomController extends GetxController {
  var provider = Get.find<RoomProvider>();
  final _paginatedList = Rx<Paginated<Room>>(Paginated());
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
    var list = await provider.index('rooms', page: paginatedList.next_page);
    paginatedList.addAll(list);
    isLoading.value = false;
  }

  init() {
    paginatedList.init();
    fetch();
  }

  Future<Room?> join(Room room) async {
    var res = await provider.join(room.id!, room.id.toString());
    return res;
  }

  Future<Room?> leave(Room room) async {
    var res = await provider.leave(room.id!, room.id.toString());
    return res;
  }
}
