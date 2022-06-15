import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/modules/login/controllers/login_controller.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/components/input_filed.dart';

import '../../../../core/components/main_input_field.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Form(
          key: controller.loginFormKey,
          child: Container(
            height: Get.height,
            // width: 200,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 10,
              vertical: MediaQuery.of(context).size.width / 10,
            ),

            // width: width * 0.66,
            child: Column(
              // physics: NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(height: 100),
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
                  isHidden: true,
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
          ),
        ),
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Stack(
        children: [
          Positioned(
            left: -100,
            top: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.indigo)],
                  gradient: LinearGradient(
                      colors: [Colors.indigoAccent, Colors.indigo],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
          ),
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: Colors.greenAccent)
                ],
                // gradient: LinearGradient(colors: [Color(0x43F68B),Color(0x43F68B)] , begin: Alignment.bottomLeft , end: Alignment.bottomRight)
              ),
            ),
          ),
          Positioned(
              right: -100,
              bottom: -80,
              child: Transform.rotate(
                angle: 0.8,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, color: Colors.indigo)
                    ],
                    // gradient: LinearGradient(colors: [Color(0x43F68B),Color(0x43F68B)] , begin: Alignment.bottomLeft , end: Alignment.bottomRight)
                  ),
                ),
              )),
          Positioned(
              left: -100,
              bottom: -100,
              child: Transform.rotate(
                angle: 3.14 / 4,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, color: Colors.greenAccent)
                    ],
                    // gradient: LinearGradient(colors: [Color(0x43F68B),Color(0x43F68B)] , begin: Alignment.bottomLeft , end: Alignment.bottomRight)
                  ),
                ),
              )),
          Center(
            child: GlassContainer.clearGlass(
              // blur: 70,
              // color: Colors.blue,
              // color: Color(0x555596F3),
              width: Get.width,
              height: Get.height,
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
