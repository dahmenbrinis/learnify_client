import 'package:get/get.dart';

import '../controllers/not_connected_controller.dart';

class NotConnectedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotConnectedController>(
      () => NotConnectedController(),
    );
  }
}
