import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/modules/register/controllers/register_controller.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/components/input_filed.dart';
import 'package:learnify_client/core/layouts/background_widget.dart';

import '../../../../core/components/main_input_field.dart';

class RegisterView extends GetView<RegisterController> {
  var selectedItem = 'Student'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        key: Key('register'),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 10,
            vertical: MediaQuery.of(context).size.width / 10,
          ),
          // width: width * 0.66,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    // SizedBox(height: 10),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/logo2.svg',
                          color: Colors.white,
                          height: 50,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    MainInputField(
                      inputText: Text(
                        'Full Name',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      icon: Icon(
                        Iconsax.user_tag,
                        color: Theme.of(context).disabledColor,
                      ),
                      inputController: controller.nameController,
                    ),
                    MainInputField(
                      inputText: Text(
                        'Email',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      icon: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).disabledColor,
                      ),
                      inputController: controller.emailController,
                    ),
                    MainInputField(
                      inputText: Text(
                        'Password',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      icon: Icon(
                        Iconsax.security,
                        color: Theme.of(context).disabledColor,
                      ),
                      inputController: controller.passwordController,
                    ),
                    // InputField(inputText: 'Register As'),
                    const SizedBox(height: 10),
                    MainInputField(
                      inputText: Text(
                        'Register as',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      icon: Icon(
                        Iconsax.security,
                        color: Theme.of(context).disabledColor,
                      ),
                      inputController: controller.passwordController,
                      input: Obx(() {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              'Register As',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: ['Student', 'Teacher']
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedItem.value,
                            onChanged: (String? value) {
                              controller.typeController.text =
                                  "Teacher" == value ? '0' : '1';
                              selectedItem.value = value ?? "Student";
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextButton(
                        child: const Text('Register'),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: Theme.of(context).textTheme.headline6,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                        ),
                        onPressed: () {
                          controller.register();
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Already registred ?',
                            style: Theme.of(context).textTheme.headline6),
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.blueAccent),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    // const Spacer(flex: 3),
                  ],
                  // mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
            // crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
