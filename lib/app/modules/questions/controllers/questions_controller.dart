import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/modules/questions/providers/question_provider.dart';
import 'package:learnify_client/app/modules/questions/question_model.dart';

import '../../../../core/pagination.dart';
import '../../../User/user_model.dart';
import '../../room/room_model.dart';

class QuestionsController extends GetxController {
  var provider = Get.find<QuestionProvider>();
  final _paginatedList = Rx<Paginated<Question>>(Paginated());
  set paginatedList(Paginated<Question> value) => _paginatedList.value = value;
  Paginated<Question> get paginatedList => _paginatedList.value;
  Room room = Get.arguments;
  User user = Auth.user;
  var isLoading = true.obs;
  var scrollController = ScrollController();

  Future fetch({int? page = null}) async {
    isLoading.value = true;
    var list = await provider.index('rooms/${room.id}/questions',
        page: page??paginatedList.next_page);
    paginatedList.addAll(list);
    isLoading.value = false;
  }

  @override
  void onInit() {
    paginatedList.init();
    fetch();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['type'] =='App\\Notifications\\QuestionAdded') {
        int page = paginatedList.current_page ;
        paginatedList.init();
        fetch(page:page);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) fetch();
    });
    super.onInit();
  }

  @override
  void onClose() {}
}
