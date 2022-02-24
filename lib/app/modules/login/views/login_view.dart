import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:learnify_client/app/modules/login/controllers/login_controller.dart';
import 'package:learnify_client/core/components/input_filed.dart';
import 'package:learnify_client/core/layouts/background_widget.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Form(
          key: controller.loginFormKey,
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
                    const Spacer(flex: 2),
                    Text("Learnify",
                        style: TextStyle(
                            color: Colors.greenAccent.shade200, fontSize: 50)),
                    const SizedBox(height: 20),
                    InputField(
                      inputText: const Text(
                        'Email',
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                      padding: 20,
                      inputController: controller.emailController,
                    ),
                    InputField(
                      inputText: const Text(
                        'Password',
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                      padding: 20,
                      inputController: controller.passwordController,
                    ),
                    // InputField(inputText: 'Register As'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextButton(
                        child:
                            const Text('Login', style: TextStyle(fontSize: 20)),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.greenAccent.shade200,
                          textStyle: const TextStyle(fontSize: 20),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width / 3, 0),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        onPressed: () {
                          controller.login();

                          // controller.login();
                          // networking.login(
                          //     email: 'dahmen@gmail.com', password: 'password');
                          // Get.toNamed('rooms');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const RoomsScreen()),
                          // );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('New User ?', style: TextStyle(fontSize: 20)),
                        TextButton(
                          onPressed: () => Get.toNamed('register'),
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.greenAccent.shade400),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    const Spacer(flex: 3),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
              // crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
