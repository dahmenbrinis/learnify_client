import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/user_model.dart';

import '../../../../core/pagination.dart';
import '../../../User/user_provider.dart';

class GlobalLeaderboardController extends GetxController {
  // final Room room = Get.arguments as Room;
  final provider = Get.find<UserProvider>();

  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _users = Paginated<User>().obs;
  Paginated<User> get users => _users.value;
  set users(Paginated<User> value) => _users.value = value;

  ScrollController scrollController = ScrollController();

  @override
  Future<void> onInit() async {
    scrollController.addListener(() {
      // if (scrollController.offset > 300 && !isHidden) isHidden = true;
      // print(scrollController.position.pixels);
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) fetch();
    });
    super.onInit();
  }

  fetch() async {
    isLoading = true;
    // var newData = await provider.index('questions/1/comments');
    var newData = await provider.index('leaderboard', page: users.next_page)
        as Paginated<User>;

    users.addAll(newData);
    isLoading = false;
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
}
