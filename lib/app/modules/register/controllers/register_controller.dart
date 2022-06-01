import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';

class RegisterController extends GetxController {
  AuthController get authController => Get.find<AuthController>();
  var loginFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final typeController = TextEditingController();
  @override
  void onInit() {
    // nameController.text = 'Teacher username';
    // emailController.text = 'teacher@gmail.com';
    // passwordController.text = 'password';
    typeController.text = '1';
    super.onInit();
  }

  @override
  void onClose() {}

  void register() {
    print(typeController.text);
    authController.register(nameController.text, emailController.text,
        passwordController.text, typeController.text);
  }
}
