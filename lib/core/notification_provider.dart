import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/notifications/database_notification_model.dart'
    as notification_model;

import '../app/User/auth.dart';

class NotificationProvider {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var notifyToken = await FirebaseMessaging.instance.getToken();
    Auth.fcm_token = notifyToken;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data);
      pushNotification(message);
    });
  }

  static void pushNotification(RemoteMessage message) {
    var notification =
        notification_model.Notification.fromJson(message.data).enhanced;
    Get.snackbar(
      '${notification.title}',
      '${notification.body}',
    );
  }
}
