import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/modules/login/controllers/login_controller.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/components/input_filed.dart';
import 'package:learnify_client/core/layouts/background_widget.dart';

import '../../../../core/components/main_input_field.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Form(
          key: controller.loginFormKey,
          child: Container(
            // height: 200,
            // width: 200,
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
                    shrinkWrap: true,
                    children: [
                      // const SizedBox(height: 10),
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
                      // const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextButton(
                          child: const Text('Login'),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
                            textStyle: Theme.of(context).textTheme.headline6,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                          ),
                          onPressed: () {
                            controller.login();
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      //TODO: try getoff it may work and fix the global key probleme //
                      Row(
                        children: [
                          Text('New User ?',
                              style: Theme.of(context).textTheme.headline6),
                          TextButton(
                            onPressed: () => Get.toNamed(Routes.REGISTER),
                            child: Text(
                              'SignUp',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
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
      ),
    );
  }
}
