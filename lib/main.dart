import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';
import 'package:learnify_client/app/User/user_provider.dart';
import 'package:learnify_client/core/notification_provider.dart';
import 'package:learnify_client/core/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await NotificationProvider.init();
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print(message.data);
  // });

  Get.put<UserProvider>(UserProvider());
  Get.put<AuthController>(AuthController());
  print(Utils.baseUrl);
  // MyWidgetsBinding();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

class MyImageCache extends ImageCache {
  @override
  void clear() {
    print('Clearing cache!');
    super.clear();
  }
}

class MyWidgetsBinding extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() => MyImageCache();
}
