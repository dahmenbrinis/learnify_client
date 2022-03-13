import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/comments/comment_model.dart';
import 'package:learnify_client/app/modules/comments/providers/comment_provider.dart';
import 'package:learnify_client/core/pagination.dart';

import '../../questions/question_model.dart';

class CommentsController extends GetxController {
  var provider = Get.find<CommentProvider>();
  final Question question = Get.arguments;
  final _paginatedList = Rx(Paginated<Comment>());

  final _isHidden = false.obs;

  get isHidden => _isHidden.value;

  set isHidden(value) => _isHidden.value = value;

  ScrollController scrollController = ScrollController();
  Paginated<Comment> get list => _paginatedList.value;
  set list(Paginated<Comment> value) => _paginatedList.value = value;
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;
  @override
  void onInit() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['type'] == 'App\\Notifications\\QuestionAdded') {
        int page = list.current_page;
        list.init();
        fetch(page: page);
        print(message.notification);
      }
    });
    scrollController.addListener(() {
      // if (scrollController.offset > 300 && !isHidden) isHidden = true;
      if (scrollController.offset == 0) isHidden = false;
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) fetch();
    });
    super.onInit();
  }

  @override
  void onReady() {
    list.init();
    fetch();
  }

  fetch({int? page = null}) async {
    isLoading = true;
    // var newData = await provider.index('questions/1/comments');
    var newData =
        await provider.index('questions/${page ?? question.id}/comments');
    list.addAll(newData);
    isLoading = false;
  }
}
