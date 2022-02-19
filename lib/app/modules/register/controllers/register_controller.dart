import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';

class RegisterController extends GetxController {
  AuthController get authController => Get.find<AuthController>();
  final loginFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final typeController = TextEditingController();
  @override
  void onInit() {
    nameController.text = 'dahmen brinis';
    emailController.text = 'sdfsdfasdf@gmail.com';
    passwordController.text = 'password';
    typeController.text = '0';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void register() {
    authController.register(
        nameController.text, emailController.text, passwordController.text,
        type: typeController.text);
  }
}
