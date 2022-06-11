import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/user_model.dart';
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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['type'] == 'App\\Notifications\\QuestionAdded') fetch();
    });
    scrollController.addListener(() {
      // if (scrollController.offset > 300 && !isHidden) isHidden = true;
      if (scrollController.offset == 0) isHidden = false;
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) fetch(reload: false);
    });
    super.onInit();
  }

  @override
  void onReady() {
    fetch();
  }

  fetch({bool reload = true}) async {
    isLoading = true;
    if (reload) list.init();
    // var newData = await provider.index('questions/1/comments');
    var newData = await provider.index('questions/${question.id}/comments',
        page: list.next_page);
    isLoading = false;
    if (newData != null) list.addAll(newData);
    rerender();
  }

  rerender() {
    _paginatedList.refresh();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}
