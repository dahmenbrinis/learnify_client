import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';

class LoginController extends GetxController {
  AuthController get authController => Get.find<AuthController>();
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Future<void> onInit() async {
    emailController.text = 'dahmen@gmail.com';
    passwordController.text = 'password';
    // login();
    super.onInit();
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  login() {
    authController.login(emailController.text, passwordController.text);
  }

  @override
  void onClose() {}
  // void increment() => count.value++;
}
