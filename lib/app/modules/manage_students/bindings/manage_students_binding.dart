import 'package:get/get.dart';

import '../../../User/user_provider.dart';
import '../../leaderboard/providers/reputation_provider.dart';
import '../controllers/manage_students_controller.dart';

class ManageStudentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<ReputationProvider>(() => ReputationProvider());

    Get.lazyPut<ManageStudentsController>(() => ManageStudentsController());
  }
}
