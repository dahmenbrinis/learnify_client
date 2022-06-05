// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
                                      SvgPicture.asset(
                                        'assets/second.svg',
                                        height: 40,
                                        width: 30,
                                      ),
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
                                    'Rank ${user.rank}',
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
                                child: Badge(
                                  padding: EdgeInsets.zero,
                                  position: BadgePosition.bottomEnd(
                                      bottom: -2, end: -10),
                                  badgeColor: Colors.blue,
                                  showBadge: user.type == 0,
                                  badgeContent: Container(
                                    padding: EdgeInsets.all(4),
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white70,
                                    ),
                                    child: Image.asset(
                                      'assets/teacher_icon.png',
                                      color: Colors.blue,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    minRadius: 40,
                                    backgroundColor: Colors.white70,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: NetImage(
                                            id: user.imageId,
                                            alt: user.name!,
                                            minSize: 200,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {},
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
                        SizedBox(height: 10),
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
                                      '${user.points}',
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
                                      'Points',
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
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.spaceBetween,
                      runSpacing: 10,
                      spacing: 10,
                      children: [
                        for (var badge in user.badges)
                          Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: badge.description,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 5),
                              width: (Get.width / 2) - 20,
                              decoration: BoxDecoration(
                                color: Color(0xFF2191FB),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    user.badgeIconUrl(badge.name!),
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      '${badge.name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Visibility(
                      visible: user.badges.isEmpty,
                      child: Text('No badges achived yet! ')),
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
                                              'assets/icons/user-Bold.svg',
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
                                              'assets/icons/envelope.svg',
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
                                              'assets/icons/lock.svg',
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
                                              'assets/icons/lock.svg',
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
