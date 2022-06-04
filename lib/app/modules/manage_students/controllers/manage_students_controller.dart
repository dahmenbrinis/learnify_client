import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';

import '../../../../core/pagination.dart';
import '../../../User/user_model.dart';
import '../../../User/user_provider.dart';
import '../../leaderboard/providers/reputation_provider.dart';
import '../../leaderboard/reputation_model.dart';

class ManageStudentsController extends GetxController {
  //TODO: Implement ManageStudentsController
  var room = Rx<Room>(Get.arguments);
  // final Room room = Get.arguments as Room;
  final provider = Get.find<UserProvider>();

  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _users = Paginated<User>().obs;
  Paginated<User> get users => _users.value;
  set users(Paginated<User> value) => _users.value = value;
  var points = Paginated<Reputation>();
  ScrollController scrollController = ScrollController();

  @override
  Future<void> onInit() async {
    try {
      points = await Get.find<ReputationProvider>()
          .index('room_leaderboard/${room.value.id}') as Paginated<Reputation>;
    } catch (e) {}
    scrollController.addListener(() {
      // if (scrollController.offset > 300 && !isHidden) isHidden = true;
      // print(scrollController.position.pixels);
      if (scrollController.position.atEdge &&
          scrollController.position.pixels > 50 &&
          users.has_next) fetch();
    });

    super.onInit();
  }

  fetch() async {
    isLoading = true;
    // var newData = await provider.index('questions/1/comments');
    var newData = await provider.index('room_management/${room.value.id}',
        page: users.next_page) as Paginated<User>;
    users.addAll(newData);
    isLoading = false;
  }

  String getPoints(User user) {
    var payee = points.data.firstWhere((element) => user.id == element.payee.id,
        orElse: () => Reputation(payee: User()));
    if (payee.id == null) return "0";
    return payee.points!;
  }

  @override
  void onReady() {
    super.onReady();
    users.init();
    fetch();
    _users.refresh();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  var isKickProgress = false.obs;
  kick(int userId) async {
    isKickProgress(true);
    var res = await provider.sendRequest(
        "rooms/${room.value.id!}/kick/$userId}", "GET");
    isKickProgress(false);
    if (res.bodyString != "1") return;
    int index = users.data.indexWhere((element) => element.id == userId);
    if (index >= 0) users.data.removeAt(index);
    _users.refresh();
  }

  var isCommendProgress = false.obs;
  commend(int userId) async {
    isKickProgress(true);
    var res = await provider.get("rooms/${room.value.id!}/commend/$userId}");
    isKickProgress(false);
    if (res.bodyString != "1") return;
    int index = users.data.indexWhere((element) => element.id == userId);
    if (index >= 0) users.data.removeAt(index);
    _users.refresh();
  }
}
