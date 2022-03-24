import 'package:get/get.dart';
import 'package:learnify_client/app/modules/comments/providers/comment_provider.dart';

import '../../home/providers/vote_provider.dart';
import '../controllers/comments_controller.dart';
import '../controllers/create_comment_controller.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentsController>(() => CommentsController());
    Get.lazyPut<CommentProvider>(() => CommentProvider());
    Get.lazyPut<VoteProvider>(() => VoteProvider());
  }
}
