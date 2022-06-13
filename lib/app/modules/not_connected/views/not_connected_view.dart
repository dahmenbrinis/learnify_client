import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/routes/app_pages.dart';

import '../controllers/not_connected_controller.dart';

class NotConnectedView extends GetView<NotConnectedController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Iconsax.cloud_connection,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 30),
            const Text(
              'Seems that you lost your connection',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please retry later',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 40),
            Container(
              width: Get.width / 3,
              child: TextButton(
                onPressed: () async {
                  Get.offAllNamed(Routes.ROOM);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Retry",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(width: 10),
                    Icon(Iconsax.refresh),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
