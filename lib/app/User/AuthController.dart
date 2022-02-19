import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:learnify_client/utils.dart';
import 'user_provider.dart';
import 'user_model.dart';

class AuthController extends GetxController {
  final _authenticated = false.obs;
  final Rx<User> _user = Rx<User>(User());
  final userProvider = Get.find<UserProvider>();

  bool get authenticated => _authenticated.value;
  User get user => _user.value;

  set authenticated(value) => _authenticated.value = value;
  set user(user) => _user.value = user;

  @override
  void onInit() {
    //TODO:Grab token from storage.
    super.onInit();
  }

  login(String email, String password) async {
    var response = await userProvider.post(
        '/api/login', {"email": email, "password": password},
        headers: userProvider.headers);
    // print('body = ${response.bodyString} ${Utils.baseUrl}');

    if (response.unauthorized) Get.snackbar('Error', 'Login unsuccessful');
    if (response.hasError) {
      Get.snackbar('Error',
          "${jsonDecode(response.bodyString ?? '{"message":"error"}')['message']}");
    }
    if (response.isOk) {
      user = response.body;
      authenticated = true;
      Get.snackbar('Welcome', 'hello ${user.name} and welcome',
          duration: Duration(seconds: 2));
      Get.offNamed('/room');
    }
  }

  register(String name, String email, String password,
      {String type = '0'}) async {
    User user = User(
        name: name, email: email, password: password, type: int.parse(type));
    var response = await userProvider.post('/api/register', user.toJson(),
        headers: userProvider.headers);
    if (response.unauthorized) Get.snackbar('Error', 'Login unsuccessful');
    if (response.hasError) {
      print('body = ${response.bodyString} ${Utils.baseUrl}');
      Get.snackbar('Error',
          "${jsonDecode(response.bodyString ?? 'message:error')['message']}");
    }
    if (response.isOk) {
      user = response.body ?? user;
      authenticated = true;
      Get.snackbar('Welcome', 'hello ${user.name} and welcome',
          duration: Duration(seconds: 2));
      Get.offNamed('/room');
    }
  }

  logout(String name, String email, String password,
      {String type = '0'}) async {
    User user = User(
        name: name, email: email, password: password, type: int.parse(type));
    var res = await userProvider.post('/api/logout', {},
        headers: userProvider.headers);
    if (res.hasError) {
      print('body = ${res.bodyString} ${Utils.baseUrl}');
      Get.snackbar('Error',
          "${jsonDecode(res.bodyString ?? 'message:error')['message']}");
    }
    if (res.isOk) {
      user = res.body ?? user;
      authenticated = true;
      Get.snackbar('Welcome', 'hello ${user.name} and welcome',
          duration: Duration(seconds: 2));
      Get.offNamed('/room');
    }
  }
}
