import 'package:get/get.dart';

import '../controllers/global_leaderboard_controller.dart';

class GlobalLeaderboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GlobalLeaderboardController>(
      () => GlobalLeaderboardController(),
    );
  }
}
