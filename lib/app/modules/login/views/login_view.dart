import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../components/input_filed.dart';
import '../../../../layouts/background_widget.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    Spacer(flex: 2),
                    Text("Learnify",
                        style: TextStyle(
                            color: Colors.greenAccent.shade200, fontSize: 50)),
                    Text("Login",
                        style: TextStyle(color: Colors.white70, fontSize: 30)),
                    SizedBox(height: 20),
                    InputField(
                      inputText: 'Email',
                      padding: 20,
                      inputController: controller.emailController,
                    ),
                    InputField(
                      inputText: 'Password',
                      padding: 20,
                      inputController: controller.passwordController,
                    ),
                    // InputField(inputText: 'Register As'),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextButton(
                        child: Text('Login'),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.greenAccent.shade200,
                          textStyle: TextStyle(fontSize: 20),
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
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('New User ?', style: TextStyle(fontSize: 20)),
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
                    Spacer(flex: 3),
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
