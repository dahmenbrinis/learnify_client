import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/components/input_filed.dart';
import 'package:learnify_client/components/select_field.dart';
import 'package:learnify_client/layouts/background_widget.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          // width: width * 0.66,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: [
                  SizedBox(height: 20),
                  Spacer(flex: 2),
                  Text("Learnify",
                      style: TextStyle(
                          color: Colors.greenAccent.shade200, fontSize: 50)),
                  const Text("Register",
                      style: TextStyle(color: Colors.white70, fontSize: 30)),
                  InputField(
                    inputText: 'Full Name',
                    inputController: controller.nameController,
                  ),
                  InputField(
                    inputText: 'Email',
                    inputController: controller.emailController,
                  ),
                  InputField(
                    inputText: 'Password',
                    inputController: controller.passwordController,
                  ),
                  // InputField(inputText: 'Register As'),
                  const SizedBox(height: 10),

                  Container(
                    color: Colors.white,
                    // decoration:BoxDecoration(shape: BorderRadius.circular(0)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 1, horizontal: 8.0),
                    child: DropdownButtonFormField<String>(
                      value: controller.typeController.text,
                      onChanged: (value) =>
                          controller.typeController.text = value ?? '0',
                      items: const [
                        DropdownMenuItem(
                          value: '1',
                          child: Text('Student'),
                        ),
                        DropdownMenuItem(
                          value: '0',
                          child: Text('Teacher'),
                        )
                      ],
                      // decoration: InputDecoration(fillColor: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextButton(
                      child: const Text('Register'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.greenAccent.shade200,
                        textStyle: TextStyle(fontSize: 20),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 3, 0),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        controller.register();
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Already registred ?',
                          style: TextStyle(fontSize: 20)),
                      TextButton(
                        onPressed: () => Get.toNamed('/login'),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20, color: Colors.greenAccent.shade400),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Spacer(flex: 3),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ))
            ],
            // crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
