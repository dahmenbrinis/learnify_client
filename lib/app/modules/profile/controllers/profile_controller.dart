import 'package:get/get.dart';
import 'package:learnify_client/app/User/user_model.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  var user = Rx<User>(Get.arguments);
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
