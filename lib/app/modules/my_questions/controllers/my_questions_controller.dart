import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/pagination.dart';
import '../../../User/auth.dart';
import '../../../User/user_model.dart';
import '../../questions/providers/question_provider.dart';
import '../../questions/question_model.dart';

class MyQuestionsController extends GetxController {
  var provider = Get.find<QuestionProvider>();
  final _paginatedList = Rx<Paginated<Question>>(Paginated());
  set paginatedList(Paginated<Question> value) => _paginatedList.value = value;
  Paginated<Question> get paginatedList => _paginatedList.value;
  // User user = Auth.user;
  var isLoading = true.obs;
  var scrollController = ScrollController();

  Future fetch({int? page = null}) async {
    isLoading.value = true;
    var list = await provider.index('my_questions',
        page: page ?? paginatedList.next_page);
    paginatedList.addAll(list);
    isLoading.value = false;
  }

  @override
  void onInit() {
    paginatedList.init();
    fetch();
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) fetch();
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}
