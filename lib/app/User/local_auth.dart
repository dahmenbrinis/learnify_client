import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/User/user_model.dart';

import '../../core/local_storage.dart';
import 'AuthController.dart';

class Authentication {
  void update() {
    if (Auth.user.id == null) return;
    LocalStorage().save('user', jsonEncode(Auth.user.toJson()));
    Auth.authenticated = true;
  }

  void logout() {
    Auth.user = User();
    Auth.refreshUser();
    LocalStorage().delete('user');
    Auth.authenticated = false;
  }

  Future<bool> isLogged() async {
    Auth.authenticated = false;
    if (await LocalStorage().isSaved('user')) {
      var user =
          User.fromJson(jsonDecode((await LocalStorage().read('user'))!));
      await Get.find<AuthController>().login(user.email!, user.password!);
    }
    return Auth.authenticated;
  }
}
