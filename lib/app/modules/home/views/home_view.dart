import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:learnify_client/core/components/avatar_image.dart';
import 'package:learnify_client/core/layouts/footer.dart';
import 'package:learnify_client/core/layouts/appBar.dart';
import 'package:learnify_client/core/utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var b = false.obs;
    // var connect = GetConnect();
    // connect.get('${Utils.baseUrl}/api/images/1').then((value) {
    //   print(value);
    // });
    return Scaffold(
        bottomNavigationBar: const Footer(),
        appBar: const CustomAppBar(title: 'Home'),
        // backgroundColor: Colors.red,
        body: GestureDetector(
          onTap: () => controller.increment(),
          child: Column(
            children: [
              // Obx(() {
              //   controller.count.value -= controller.count.value > 5 ? 5 : 0;
              //   return FadeInImage.assetNetwork(
              //       placeholder: 'assets/loading2.gif',
              //       image: '${Utils.baseUrl}/api/images/${controller.count}');
              // }),
            ],
          ),
        ));
  }
}
