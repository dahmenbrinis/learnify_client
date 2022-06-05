import 'package:get/get.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/app/User/user_provider.dart';
import 'package:learnify_client/core/components/Dialogs.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final user = Rx<User>(Get.arguments);
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
  var email = "".obs;
  var userName = "".obs;
  saveInformation() async {
    email.value = (email.value.isEmpty ? user.value.email : email.value)!;
    userName.value =
        (userName.value.isEmpty ? user.value.name : userName.value)!;
    var json = <String, dynamic>{};
    json['email'] = email.value;
    json['name'] = userName.value;
    if (json.isEmpty) return;
    var res = await Get.find<UserProvider>()
        .sendRequest("profile", "POST", body: json);
    if (res.bodyString != '1') return;
    successModal("success", "you information has been updated successfully ",
        "Return", Get.back);
    user.value.email = email.value;
    user.value.name = userName.value;
    Auth.user = user.value;
    user.refresh();
  }

  var oldPassword = "".obs;
  var newPassword = "".obs;
  saveSecurityInformation() async {
    var json = <String, dynamic>{};
    if (oldPassword.value.isNotEmpty) json['password'] = oldPassword.value;
    if (newPassword.value.isNotEmpty) json['newPassword'] = newPassword.value;
    if (json.length < 2) return;
    var res = await Get.find<UserProvider>()
        .sendRequest("updatePassword", "POST", body: json);
    if (res.bodyString == null || !res.bodyString!.contains("|")) return;
    successModal("success", "the password has been updated successfully ",
        "Return", Get.back);
    Auth.user.token = res.bodyString;
    user.refresh();
  }
}
