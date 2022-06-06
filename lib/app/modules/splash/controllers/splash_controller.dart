import 'dart:async';

import 'package:get/get.dart';
import 'package:learnify_client/app/User/local_auth.dart';
import 'package:learnify_client/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 2;
  final isReady = false.obs;
  final isTextReady = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    isReady(true);
    Future.delayed(Duration(seconds: count)).then((value) => isTextReady(true));
    await Future.delayed(Duration(seconds: 2 * count - 1));
    await Authentication().isLogged();
    Get.toNamed(Routes.ROOM);
    super.onReady();
  }

  @override
  void onClose() {}
}
