import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';
import 'package:learnify_client/app/User/user_provider.dart';
import 'package:learnify_client/utils.dart';
// import 'package:learnify_client/utils.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.put<UserProvider>(UserProvider());
  Get.put<AuthController>(AuthController());
  print(Utils.baseUrl);
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
