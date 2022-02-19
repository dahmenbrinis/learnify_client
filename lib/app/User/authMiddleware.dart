import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';
import 'package:learnify_client/app/modules/login/controllers/login_controller.dart';

class AuthMiddleware extends GetMiddleware {
  bool check = false;
  var authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    // return const RouteSettings(name: '/login');
    if (authController.authenticated ||
        route == '/register' ||
        route == '/login') return null;
    return const RouteSettings(name: '/login');
  }
}
