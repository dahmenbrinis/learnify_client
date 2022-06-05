import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/app/User/user_provider.dart';
import 'package:learnify_client/core/components/Dialogs.dart';
import 'package:learnify_client/core/models/image_model.dart';

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

  var progress = 0.1.obs;
  Rx<XFile?> image = Rx(null);

  chooseImage() async {
    final ImagePicker _picker = ImagePicker();
    image.value =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    var data = {
      'image': MultipartFile(await image.value!.readAsBytes(),
          filename: image.value!.path),
      'imagable_type': 'App\\Models\\User',
      'imagable_id': '${user.value.id}',
      'alt': '${user.value.name}',
    };
    await confirmationModal(
      "change photo",
      "are you sure you want to chage your profile picture ? ",
      "Change",
      "cancel",
      () => uploadImage(data),
      Get.back,
    );
    print('done ;');
    image.value = null;
    progress.value = 0;
  }

  uploadImage(data) async {
    var res = await Get.find<UserProvider>().sendRequest("images", "POST",
        body: FormData(data), uploadProgress: (value) {
      if (progress.value * 100 + 10 < value) {
        progress.value = value / 100;
      }
    });
    if (res.bodyString != null && res.bodyString!.contains("User")) {
      var image = Image.fromJson(jsonDecode(res.bodyString!));
      Auth.user.imageId = image.id;
      user.value.imageId = image.id;
      user.refresh();
    }
    Get.back();
  }
}
