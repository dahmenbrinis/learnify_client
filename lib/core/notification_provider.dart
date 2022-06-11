import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/notifications/database_notification_model.dart'
    as notification_model;

import '../app/User/auth.dart';

class NotificationProvider {
  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var notifyToken = await FirebaseMessaging.instance.getToken();
    Auth.fcm_token = notifyToken;

    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/logo2',
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            importance: NotificationImportance.High,
            defaultColor: Colors.blue,
            ledColor: Colors.white,
            playSound: true,
          )
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupkey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification receivedNotification) {
      print(receivedNotification.body);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data);
      pushNotification(message);
    });
  }

  void pushNotification(RemoteMessage message) {
    var notification =
        notification_model.Notification.fromJson(message.data).enhanced;
    AwesomeNotifications().createNotification(
      actionButtons: [
        // NotificationActionButton(
        //   key: 'dismiss',
        //   label: 'dismiss',
        //   autoDismissible: false,
        //
        // )
      ],
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: '${notification.title}',
          body: '${notification.body}',
          backgroundColor: Colors.blue),
    );
    // Get.snackbar(
    //   '${notification.title}',
    //   '${notification.body}',
    // );
  }

  notificationWidget(notification_model.Notification notification) {}
}
