import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';
import 'package:learnify_client/app/User/user_provider.dart';
import 'package:learnify_client/core/notification_provider.dart';
import 'package:learnify_client/core/theme.dart';
import 'package:learnify_client/core/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
  NotificationProvider().pushNotification(message);
}

Future<void> main() async {
  await NotificationProvider().init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print(message.data);
  // });
  var initSettings = const AndroidInitializationSettings('assets/logo.svg');
  InitializationSettings(android: initSettings);

  Get.put<UserProvider>(UserProvider());
  Get.put<AuthController>(AuthController());
  print(Utils.baseUrl);
  var subscription = Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) async {
    // Got a new connectivity status!
    print(result);
    final res = await InternetAddress.lookup('example.com');
    if (result == ConnectivityResult.bluetooth ||
        result == ConnectivityResult.none ||
        res.isEmpty ||
        res[0].rawAddress.isEmpty) {
      Get.toNamed(Routes.NOT_CONNECTED);
    }
  });
  // MyWidgetsBinding();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: CustomThemes.mainTheme,
      debugShowCheckedModeBanner: false,
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
