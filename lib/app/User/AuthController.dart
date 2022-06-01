import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/provider.dart';
import 'package:learnify_client/core/utils.dart';
import 'auth.dart';
import 'user_provider.dart';
import 'user_model.dart';

class AuthController extends GetxController {
  final provider = Get.find<UserProvider>();

  login(String email, String password) async {
    var response = await provider.post(
        '/api/login', {"email": email, "password": password},
        headers: provider.headers);
    // print('body = ${response.bodyString} ${Utils.baseUrl}');

    if (response.unauthorized) Get.snackbar('Error', 'Login unsuccessful');
    if (response.hasError) {
      Get.snackbar('Error',
          "${jsonDecode(response.bodyString ?? '{"message":"error"}')['message']}");
    }
    if (response.isOk) {
      Auth.user = response.body;
      Auth.authenticated = true;
      await updateFcmToken();
      Get.snackbar('Welcome', 'hello ${Auth.user.name} and welcome',
          duration: const Duration(seconds: 2));
      Get.offNamed('/room');
    }
  }

  register(String name, String email, String password, String type) async {
    Auth.user = User(
        name: name, email: email, password: password, type: int.parse(type));
    var response = await provider.post('/api/register', Auth.user.toJson(),
        headers: provider.headers);
    if (response.unauthorized) Get.snackbar('Error', 'Login unsuccessful');
    if (response.hasError) {
      // print('body = ${response.bodyString} ${Utils.baseUrl}');
      Get.snackbar('Error',
          "${jsonDecode(response.bodyString ?? 'message:error')['message']}");
    }
    if (response.isOk) {
      Auth.user = response.body ?? Auth.user;
      Auth.authenticated = true;
      await updateFcmToken();
      Get.snackbar('Welcome', 'hello ${Auth.user.name} and welcome',
          duration: const Duration(seconds: 2));
      Get.offNamed(Routes.ROOM);
    }
  }

  logout() async {
    var res = await provider.sendRequest('logout', "POST");
    // if (res.hasError) {
    //   print('body = ${res.bodyString} ${Utils.baseUrl}');
    //   Get.snackbar('Error',
    //       "${jsonDecode(res.bodyString ?? 'message:error')['message']}");
    // }
    if (res.isOk) {
      Auth.user = res.body;
      Auth.authenticated = false;
      Get.offNamed(Routes.LOGIN);
    }
  }

  updateFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    provider.sendRequest('fcm_update', 'POST',
        headers: provider.headers, body: {'fcm_token': token});
  }
}
