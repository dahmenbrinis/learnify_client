import 'package:get/get.dart';
import 'package:learnify_client/app/modules/comments/providers/comment_provider.dart';

import '../controllers/comments_controller.dart';
import '../controllers/create_comment_controller.dart';

class CreateCommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCommentController>(() => CreateCommentController());
  }
}
