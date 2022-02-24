import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/register/controllers/register_controller.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/components/input_filed.dart';
import 'package:learnify_client/core/layouts/background_widget.dart';

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
                  const SizedBox(height: 20),
                  const Spacer(flex: 2),
                  const SizedBox(height: 20),

                  Text("Learnify",
                      style: TextStyle(
                          color: Colors.greenAccent.shade200, fontSize: 50)),
                  const SizedBox(height: 10),
                  InputField(
                    inputText: const Text(
                      'Full Name',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                    inputController: controller.nameController,
                  ),
                  InputField(
                    inputText: const Text(
                      'Email',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                    inputController: controller.emailController,
                  ),
                  InputField(
                    inputText: const Text(
                      'Password',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                    inputController: controller.passwordController,
                  ),
                  // InputField(inputText: 'Register As'),
                  const SizedBox(height: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text(
                          "Register As",
                          style: TextStyle(fontSize: 20, color: Colors.white70),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        // decoration:BoxDecoration(shape: BorderRadius.circular(0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8.0),
                        child: DropdownButtonFormField<String>(
                          value: controller.typeController.text,
                          onChanged: (value) =>
                              controller.typeController.text = value!,
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
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextButton(
                      child: const Text('Register'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.greenAccent.shade200,
                        textStyle: const TextStyle(fontSize: 20),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 3, 0),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        controller.register();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('Already registred ?',
                          style: TextStyle(fontSize: 20)),
                      TextButton(
                        onPressed: () => Get.offNamed(Routes.LOGIN),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20, color: Colors.greenAccent.shade400),
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
    );
  }
}
