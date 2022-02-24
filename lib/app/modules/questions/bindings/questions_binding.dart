import 'package:get/get.dart';
import 'package:learnify_client/app/modules/questions/bindings/create_question_binding.dart';
import 'package:learnify_client/app/modules/questions/controllers/create_question_controller.dart';
import 'package:learnify_client/app/modules/questions/providers/question_provider.dart';

import '../controllers/questions_controller.dart';

class QuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionsController>(() => QuestionsController());
    Get.lazyPut<QuestionProvider>(() => QuestionProvider());
    Get.lazyPut<CreateQuestionController>(() => CreateQuestionController());
  }
}
