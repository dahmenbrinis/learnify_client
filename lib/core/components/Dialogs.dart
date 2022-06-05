import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

Color TextColor = Colors.black87;
void confirmationModal(String title, String body, String confirmText,
    String cancelText, Function onConfirm, Function onCancel) {
  Get.defaultDialog(
    backgroundColor: Colors.transparent,
    barrierDismissible: false,
    title: '',
    radius: 20,
    content: Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      '${title}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TextColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${body}',
                      style: TextStyle(
                        fontSize: 15,
                        color: TextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        //margin: EdgeInsets.all(20),
                        width: Get.width / 4,
                        height: 56,
                        child: Opacity(
                          opacity: 0.7,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                onCancel();
                              },
                              child: Text(
                                '${cancelText}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                      Container(
                        //margin: EdgeInsets.all(20),
                        width: Get.width / 4,
                        height: 56,
                        child: Opacity(
                          opacity: 0.8,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                onConfirm();
                              },
                              child: Text(
                                '${confirmText}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                ],
              )),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Iconsax.close_circle,
                  size: 34,
                  color: TextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void successModal(
    String title, String body, String confirmText, Function onConfirm) {
  Get.defaultDialog(
    backgroundColor: Colors.transparent,
    barrierDismissible: false,
    title: '',
    radius: 20,
    content: Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      '${title}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TextColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${body}',
                      style: TextStyle(
                        fontSize: 15,
                        color: TextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //margin: EdgeInsets.all(20),
                        width: Get.width / 2,
                        height: 56,
                        child: Opacity(
                          opacity: 0.8,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                onConfirm();
                              },
                              child: Text(
                                '${confirmText}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                ],
              )),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Iconsax.close_circle,
                  size: 34,
                  color: TextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void errorModal(
    String title, String body, String cancelText, Function onCancel) {
  Get.defaultDialog(
    backgroundColor: Colors.transparent,
    barrierDismissible: false,
    title: '',
    radius: 20,
    content: Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      '${title}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TextColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${body}',
                      style: TextStyle(
                        fontSize: 15,
                        color: TextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //margin: EdgeInsets.all(20),
                        width: Get.width / 2,
                        height: 56,
                        child: Opacity(
                          opacity: 0.7,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                onCancel();
                              },
                              child: Text(
                                '${cancelText}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                ],
              )),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Iconsax.close_circle,
                  size: 34,
                  color: TextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
