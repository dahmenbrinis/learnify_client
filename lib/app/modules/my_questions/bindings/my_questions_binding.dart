import 'package:get/get.dart';
import 'package:learnify_client/app/modules/questions/providers/question_provider.dart';

import '../../home/providers/vote_provider.dart';
import '../controllers/my_questions_controller.dart';

class MyQuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyQuestionsController>(() => MyQuestionsController());
    Get.lazyPut<QuestionProvider>(() => QuestionProvider());
    Get.lazyPut<VoteProvider>(() => VoteProvider());
  }
}
