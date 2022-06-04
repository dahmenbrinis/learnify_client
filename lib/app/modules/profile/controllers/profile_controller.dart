import 'package:get/get.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/app/User/user_provider.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  var user = Rx<User>(Get.arguments);
  final count = 0.obs;
  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  var isLoading = false.obs;
  fetch() async {
    isLoading(true);
    var res = await Get.find<UserProvider>()
        .sendRequest("profile/${user.value.id}", "GET");
    isLoading(false);
    if (res.body == null) return;
    user.value = res.body;
    user.refresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
