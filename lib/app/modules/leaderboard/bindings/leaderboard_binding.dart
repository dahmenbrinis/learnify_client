import 'package:get/get.dart';
import 'package:learnify_client/app/modules/leaderboard/providers/reputation_provider.dart';

import '../controllers/leaderboard_controller.dart';

class LeaderboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaderboardController>(() => LeaderboardController());
    Get.lazyPut<ReputationProvider>(() => ReputationProvider());
  }
}
