import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learnify_client/app/User/AuthController.dart';
import 'package:learnify_client/app/User/user_provider.dart';
import 'package:learnify_client/core/notification_provider.dart';
import 'package:learnify_client/core/theme.dart';
import 'package:learnify_client/core/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'app/routes/app_pages.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
  NotificationProvider().pushNotification(message);
}

Future<void> execute(
  InternetConnectionChecker internetConnectionChecker,
) async {
  // Simple check to see if we have Internet
  // ignore: avoid_print
  print('''The statement 'this machine is connected to the Internet' is: ''');
  final bool isConnected = await InternetConnectionChecker().hasConnection;
  // ignore: avoid_print
  print(
    isConnected.toString(),
  );
  // returns a bool

  // We can also get an enum instead of a bool
  // ignore: avoid_print
  print(
    'Current status: ${await InternetConnectionChecker().connectionStatus}',
  );
  // Prints either InternetConnectionStatus.connected
  // or InternetConnectionStatus.disconnected

  // actively listen for status updates
  final StreamSubscription<InternetConnectionStatus> listener =
      InternetConnectionChecker().onStatusChange.listen(
    (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case InternetConnectionStatus.disconnected:
          Get.offAllNamed(Routes.NOT_CONNECTED);
          print('You are disconnected from the internet.');
          break;
      }
    },
  );
}

class Connections {
  static InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
}

Future<void> main() async {
  await NotificationProvider().init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print(message.data);
  // });
  await execute(Connections.internetConnectionChecker);
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
    if (result == ConnectivityResult.bluetooth ||
        result == ConnectivityResult.none) {
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
