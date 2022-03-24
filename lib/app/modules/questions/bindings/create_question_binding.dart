import 'package:get/get.dart';

import '../controllers/create_question_controller.dart';
import '../controllers/questions_controller.dart';
import '../providers/question_provider.dart';

class CreateQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateQuestionController>(() => CreateQuestionController());
    Get.lazyPut<QuestionProvider>(() => QuestionProvider());
    Get.lazyPut<QuestionsController>(() => QuestionsController());
  }
}
