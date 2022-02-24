import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:learnify_client/core/layouts/footer.dart';
import 'package:learnify_client/core/layouts/appBar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Footer(),
      appBar: const CustomAppBar(title: 'Home'),
      body: Column(
        children: [
          const SizedBox(height: 20),
          FadeInImage.assetNetwork(
              placeholder: 'test',
              image: 'http://192.168.149.254:8000/api/test.png'),
        ],
      ),
    );
  }
}
