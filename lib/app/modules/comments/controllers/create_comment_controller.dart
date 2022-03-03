import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/comments/comment_model.dart';
import 'package:learnify_client/app/modules/comments/providers/comment_provider.dart';
import 'package:learnify_client/app/modules/questions/question_model.dart';

import '../../../User/auth.dart';

class CreateCommentController extends GetxController {
  //TODO: Implement CreateCommentController
  var provider = Get.find<CommentProvider>();
  Question question = Get.arguments;
  Comment? comment;
  final count = 0.obs;

  var bodyController = TextEditingController();

  var titleController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  addComment() async {
    comment = Comment(title: titleController.text, body: bodyController.text);
    comment!.user = Auth.user;
    comment =
        await provider.create('questions/${question.id}/comments', comment!);
    if (comment != null) Get.back(result: comment);
  }
}
