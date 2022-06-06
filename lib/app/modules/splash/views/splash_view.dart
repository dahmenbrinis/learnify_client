import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
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
                    Obx(() {
                      return AnimatedOpacity(
                        duration: Duration(seconds: controller.count),
                        opacity: controller.isReady.isTrue ? 1 : 0,
                        child: AnimatedContainer(
                          curve: Curves.bounceOut,
                          width: controller.isReady.isTrue ? 100 : 0,
                          height: controller.isReady.isTrue ? 100 : 20,
                          duration: Duration(seconds: controller.count),
                          child: AnimatedRotation(
                            curve: Curves.bounceOut,
                            duration: Duration(seconds: controller.count),
                            turns: controller.isReady.isTrue ? 0 : -0.5,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: controller.isReady.isTrue ? 50 : 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/logo2.svg',
                                  color: Colors.white,
                                  height: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 10),
                    Obx(() {
                      return AnimatedOpacity(
                        curve: Curves.decelerate,
                        duration: Duration(seconds: controller.count),
                        opacity: controller.isTextReady.isTrue ? 1 : 0,
                        child: const Center(
                          child: Text(
                            "Learnify",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
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

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.greenAccent)],
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
            blur: 20,
            // color: Colors.blue,
            // color: Color(0x555596F3),
            width: double.infinity,
            height: double.infinity,
            child: child,
          ),
        )
      ],
    );
  }
}
