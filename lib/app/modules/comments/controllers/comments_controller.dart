import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/comments/comment_model.dart';
import 'package:learnify_client/app/modules/comments/providers/comment_provider.dart';
import 'package:learnify_client/core/pagination.dart';

import '../../questions/question_model.dart';

class CommentsController extends GetxController {
  //TODO: Implement CommentsController
  var provider = Get.find<CommentProvider>();
  final Question question = Get.arguments;
  final _paginatedList = Rx(Paginated<Comment>());

  var scrollController = ScrollController();
  Paginated<Comment> get list => _paginatedList.value;
  set list(Paginated<Comment> value) => _paginatedList.value = value;
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;
  @override
  void onInit() {
    scrollController.addListener(() {
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

  fetch() async {
    isLoading = true;
    // var newData = await provider.index('questions/1/comments');
    var newData = await provider.index('questions/${question.id}/comments');
    list.addAll(newData);
    isLoading = false;
  }
}
