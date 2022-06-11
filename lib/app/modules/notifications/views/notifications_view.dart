// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Obx(() {
                        return Text(
                          controller.count.value <= 0
                              ? "There are no new notifications"
                              : 'You have ${controller.count.value} new notifications',
                          style: TextStyle(
                              color: Colors.black,
                              // fontWeight: FontWeight.bold,
                              fontSize: 16),
                        );
                      }),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        controller.markAsRead();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // color: Colors.blue,
                        ),
                        child: Text(
                          'Mark all as Read',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black54,
                endIndent: 15,
                indent: 15,
              ),
              Obx(() {
                if (controller.isLoading.isTrue ||
                    controller.isMarking.isTrue) {
                  return Container(
                    height: Get.height / 2 + 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Container(
                    width: Get.width,
                    height: Get.height - 220,
                    child: ListView.builder(
                      itemCount: controller.list.value.length,
                      itemBuilder: (context, index) {
                        var item = controller.list.value.data[index];
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: item.readAt == null
                                    ? Colors.blue
                                    : Color(0xD85B85A1),
                              ),
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${item.data!.enhanced.title}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "${item.createdAt!.substring(0, 10)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    '${item.data!.enhanced.body}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
