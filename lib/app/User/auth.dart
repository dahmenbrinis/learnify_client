import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:learnify_client/app/User/local_auth.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/app/User/user_provider.dart';

class Auth {
  static RxBool _authenticated = false.obs;
  static Rx<User> _user = Rx<User>(User());
  static Rx<Object> obj = Rx<Object>(Object());
  static bool get authenticated => _authenticated.value;
  static User get user => _user.value;
  static set authenticated(value) => _authenticated.value = value;
  static set user(user) => _user.value = user;
  static String? fcm_token = null;
  static refreshPoints() async {
    final provider = Get.find<UserProvider>();
    var res = await provider.sendRequest('updatePoints', "GET");
    user.points = res.bodyString;
    refreshUser();
  }

  static refreshUser() {
    _user.refresh();
    Authentication().update();
  }
}
