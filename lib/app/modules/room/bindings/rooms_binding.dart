import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/providers/room_provider.dart';

import '../controllers/rooms_controller.dart';

class RoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomController>(() => RoomController());
    Get.lazyPut(() => RoomProvider());
  }
}
