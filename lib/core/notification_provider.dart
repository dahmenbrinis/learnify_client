import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app/User/auth.dart';
class NotificationProvider{
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
    switch(message.data['type'] as String){
      case 'App\\Notifications\\QuestionAdded':
        Get.snackbar('${message.data['title']} asked a question', '${message.data['body']}',);
        break;
      case 'App\\Notifications\\NewCommentNotification':
        Get.snackbar('${message.data['title']} Commented on your post', '${message.data['body']}',);
        break;
    }
  }


}

