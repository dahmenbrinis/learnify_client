// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../core/components/avatar_image.dart';
import '../../../../core/components/net_image.dart';
import '../../../User/auth.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          child: Container(
            child: Obx(() {
              var user = controller.user.value;
              print(controller.badgesList.length);
              var count = 6;
              var disabledBadges = [...controller.badgesList.value];
              for (var badge in user.badges) {
                disabledBadges
                    .removeWhere((element) => element.name == badge.name);
              }
              print(controller.badgesList.length);
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF2191FB),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: Get.back,
                                child: Row(
                                  children: [
                                    Icon(
                                      Iconsax.direct_left5,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      'Back',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      if (user.type == 0)
                                        Container(
                                          margin: EdgeInsets.only(bottom: 4),
                                          padding: EdgeInsets.all(4),
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.white70,
                                          ),
                                          child: Image.asset(
                                            'assets/teacher_icon.png',
                                            color: Colors.blue,
                                          ),
                                        ),
                                      if (user.type != 0)
                                        SvgPicture.asset(
                                          'assets/second.svg',
                                          height: 40,
                                          width: 30,
                                        ),
                                      if (user.type != 0)
                                        Positioned(
                                          top: 6,
                                          right: 11,
                                          child: Text(
                                            '${user.rank}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    user.type == 0
                                        ? "Teacher"
                                        : 'Rank ${user.rank}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Stack(
                          children: [
                            Container(
                                width: 90,
                                height: 90,
                                child: CircleAvatar(
                                  minRadius: 40,
                                  backgroundColor: Colors.white70,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Obx(() {
                                      var image = controller.image.value;

                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: image != null
                                              ? Stack(
                                                  children: [
                                                    Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(200),
                                                      ),
                                                      child: Image.file(
                                                        File(image.path),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    LiquidCircularProgressIndicator(
                                                      value: controller
                                                          .progress.value,
                                                      valueColor:
                                                          AlwaysStoppedAnimation(
                                                              Colors.white70),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      borderColor:
                                                          Colors.white70,
                                                      borderWidth: 3,
                                                      direction: Axis
                                                          .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                    ),
                                                  ],
                                                )
                                              : NetImage(
                                                  id: user.imageId,
                                                  alt: user.alt,
                                                  minSize: 200,
                                                ),
                                        ),
                                      );
                                    }),
                                  ),
                                )),
                            Visibility(
                              visible: user.id == Auth.user.id &&
                                  controller.image.value == null,
                              child: GestureDetector(
                                onTap: () {
                                  controller.chooseImage();
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/camera.svg',
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            '${user.name}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '${user.email}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        if (user.type != 0) SizedBox(height: 10),
                        if (user.type != 0)
                          SizedBox(
                            width: 200,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Points : ${user.points} point',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: StepProgressIndicator(
                                    totalSteps:
                                        user.requiredPoints(user.rank + 1) -
                                            user.requiredPoints(user.rank),
                                    currentStep:
                                        int.tryParse(user.points ?? '0')! -
                                            user.requiredPoints(user.rank),
                                    size: 5,
                                    selectedSize: 6,
                                    padding: 0,
                                    selectedColor: Colors.greenAccent,
                                    unselectedColor: Colors.white,
                                    roundedEdges: Radius.circular(10),
                                  ),
                                )),
                                SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${user.remainingPoints} Points to reach rank ${user.rank + 1}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFF2191FB), width: 3),
                    ),
                    child: StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      // '${controller.progress.value * 100}',
                                      '${user.comments_count}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Questions Answered',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${user.valid_comments_count}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Valid Answers',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${user.questions_count}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Question Asked',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${user.type == 0 ? user.owned_rooms_count : user.points}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      user.type == 0
                                          ? 'created rooms'
                                          : 'Points',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${user.rooms_count}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Subscribed rooms',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Achieved Badges',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.spaceAround,
                      runSpacing: 10,
                      spacing: 10,
                      children: [
                        for (var badge in user.badges)
                          if (count-- > 0 || !controller.isBadgesHidden.value)
                            BadgeCard(badge),
                        for (var badge in disabledBadges)
                          if (count-- > 0 || !controller.isBadgesHidden.value)
                            BadgeCard(badge, isDisabled: true),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: user.badges.isEmpty,
                      child: Text('No badges achived yet! ')),
                  // SizedBox(height: 15),
                  Container(
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          return TextButton(
                            onPressed: () {
                              controller.isBadgesHidden.value =
                                  !controller.isBadgesHidden.value;
                              count = 6;
                            },
                            child: Text(controller.isBadgesHidden.value
                                ? 'load more'
                                : 'load less'),
                          );
                        })
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Visibility(
                    visible: Auth.user.id == user.id,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Account information',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    )
                                  ],
                                ),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Full name',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    SizedBox(
                                      child: TextFormField(
                                        initialValue: user.name,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onSaved: (value) {},
                                        keyboardType: TextInputType.text,
                                        validator: (value) {},
                                        onChanged: controller.userName,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(fontSize: 0),
                                          counterText: '',
                                          suffixIcon: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 12),
                                            child: SvgPicture.asset(
                                              'assets/user-Bold.svg',
                                              width: 20,
                                              color: Color(0xFF777777),
                                            ),
                                          ),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    SizedBox(
                                      child: TextFormField(
                                        initialValue: user.email,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onSaved: (value) {},
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {},
                                        onChanged: controller.email,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(fontSize: 0),
                                          counterText: '',
                                          suffixIcon: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 8),
                                            child: SvgPicture.asset(
                                              'assets/envelope.svg',
                                              width: 24,
                                              color: Color(0xFF777777),
                                            ),
                                          ),
                                          // hintText: 'Dahmenbriniss@gmail.com',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      width: double.infinity,
                                      height: 44,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          backgroundColor: Color(0xFF2191FB),
                                        ),
                                        onPressed: controller.saveInformation,
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Account security',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    )
                                  ],
                                ),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Old password',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    SizedBox(
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onSaved: (value) {},
                                        obscureText: true,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {},
                                        onChanged: controller.oldPassword,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(fontSize: 0),
                                          counterText: '',
                                          suffixIcon: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 8),
                                            child: SvgPicture.asset(
                                              'assets/lock.svg',
                                              width: 20,
                                              color: Color(0xFF777777),
                                            ),
                                          ),
                                          hintText: 'Old password',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'New password',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    SizedBox(
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onSaved: (value) {},
                                        obscureText: true,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {},
                                        onChanged: controller.newPassword,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(fontSize: 0),
                                          counterText: '',
                                          suffixIcon: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 8),
                                            child: SvgPicture.asset(
                                              'assets/lock.svg',
                                              width: 24,
                                              color: Color(0xFF777777),
                                            ),
                                          ),
                                          hintText: 'New password',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Color(0xFF777777),
                                            ),
                                            gapPadding: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      width: double.infinity,
                                      height: 44,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          backgroundColor: Color(0xFF2191FB),
                                        ),
                                        onPressed: () {
                                          controller.saveSecurityInformation();
                                        },
                                        child: Text(
                                          'Update',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class BadgeCard extends StatelessWidget {
  Badges badge;
  bool isDisabled;

  BadgeCard(this.badge, {this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      message: "\n${badge.name}:\n${badge.description}\nrarity: ${getLevel()}" +
          (!isDisabled ? "\nrecived at: ${getTime()}\n" : "\n"),
      child: getBackgroundBadge(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          badgeIconUrl(),
          SizedBox(width: 7),
          Flexible(
            child: Text(
              '${badge.name}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      )),
    );
  }

  getLevel() {
    switch (badge.level) {
      case 1:
        return 'Commune';
      case 2:
        return 'Rare';
      case 3:
        return 'Legendary';
      case 4:
        return 'Mythic';
    }
    return '';
  }

  Widget getBackgroundBadge(Widget child) {
    var color = () {
      switch (badge.level) {
        case 1:
          return Colors.blue;
        case 2:
          return Colors.indigo;
        case 3:
          return Color(0xffffd700);
        case 4:
          return Color(0xffff8c00);
      }
      return Colors.blue;
    }();
    var main = Stack(
      children: [
        if (badge.level == 2)
          Positioned(
            right: 6,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(-(pi / 2)),
              child: Icon(
                Iconsax.medal_star,
                color: color,
                size: 40,
              ),
            ),
          ),
        if (badge.level == 2)
          Positioned(
            left: 6,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ((pi / 2)),
              child: Icon(
                Iconsax.medal_star,
                color: color,
                size: 40,
              ),
            ),
          ),
        if (badge.level == 4 || badge.level == 3)
          Positioned(
            left: -1,
            child: Image.asset(
              'assets/wings.png',
              color: color,
              height: 40,
              width: 40,
            ),
          ),
        if (badge.level == 4 || badge.level == 3)
          Positioned(
            right: -1,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: Image.asset(
                'assets/wings.png',
                color: color,
                height: 40,
                width: 40,
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          width: (Get.width / 2) - 70,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ],
    );
    if (isDisabled) {
      return Container(
        foregroundDecoration: BoxDecoration(
          color: Colors.grey,
          backgroundBlendMode: BlendMode.saturation,
        ),
        child: main,
      );
    }
    return main;
  }

  Widget badgeIconUrl() {
    switch (badge.name) {
      case "Recommended":
        return Icon(
          Iconsax.like_shapes,
          color: Colors.white,
          size: 25,
        );
      case "Champion":
        return SvgPicture.asset(
          'assets/badges/gold-winner-trophy.svg',
          width: 25,
          height: 25,
          color: Color(0xffffd700),
        );
      case "Hotshot":
        return SvgPicture.asset(
          'assets/badges/flames.svg',
          width: 25,
          height: 25,
          color: Color(0xffffd700),
        );
      case "Novice":
        return SvgPicture.asset(
          'assets/badges/red-flag.svg',
          width: 25,
          height: 25,
          theme: SvgTheme(currentColor: Colors.pink, fontSize: 16),
        );
      case "The Expert":
        return SvgPicture.asset(
          'assets/badges/experience-expert.svg',
          width: 25,
          height: 25,
          color: Colors.white,
        );
      case "Brainiac":
        return SvgPicture.asset(
          'assets/badges/mind.svg',
          width: 25,
          height: 25,
          color: Colors.white,
        );
      case "Learnify Member":
        return Image.asset(
          'assets/logo2.png',
          width: 25,
          height: 25,
          color: Colors.white,
        );
      case "Rockstar":
        return SvgPicture.asset(
          'assets/badges/female-rock-star-sunglasses-svgrepo-com.svg',
          width: 30,
          height: 30,
          color: Colors.pink,
        );
      case "6 Month Member":
        return Icon(
          Iconsax.calendar_1,
          size: 25,
          color: Colors.white,
        );
      case "1 Month Member":
        return Icon(
          Iconsax.calendar_1,
          size: 25,
          color: Colors.white,
        );
      case "Pin Point Accurate":
        return SvgPicture.asset(
          'assets/badges/target-focus.svg',
          width: 25,
          height: 25,
          color: Colors.pink,
        );
      case "1 Year Member":
        return Icon(
          Iconsax.calendar_1,
          size: 25,
          color: Colors.white,
        );
      case "Prodigy":
        return SvgPicture.asset(
          'assets/badges/alien-svgrepo-com.svg',
          width: 25,
          height: 25,
          // color: Colors.black54,
          theme: SvgTheme(fontSize: 20, currentColor: Colors.black),
        );
      case "Curiosity":
        return SvgPicture.asset(
          'assets/badges/decision.svg',
          width: 20,
          height: 20,
          color: Colors.white,
          // theme: SvgTheme(fontSize: 20, currentColor: Colors.black),
        );
    }
    return SvgPicture.asset(
      'assets/second.svg',
      width: 30,
      height: 30,
    );
  }

  getTime() {
    return badge.createdAt!.substring(0, 10);
  }
}
