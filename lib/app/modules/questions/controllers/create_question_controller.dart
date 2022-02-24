import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/questions/controllers/questions_controller.dart';
import 'package:learnify_client/app/modules/questions/question_model.dart';

import '../../room/room_model.dart';
import '../providers/question_provider.dart';

class CreateQuestionController extends GetxController {
  //TODO: Implement CreateQuestionController
  Room room = Get.arguments;
  Question? question;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  addQuestion() async {
    question = Question(
        title: titleController.text, description: descriptionController.text);
    var provider = Get.find<QuestionProvider>();
    question = await provider.create('rooms/${room.id}/questions', question!);
    if (question != null) {
      Get.find<QuestionsController>().paginatedList.data.insert(0, question!);
    }
    Get.back();
  }
}
