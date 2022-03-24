import 'package:learnify_client/app/modules/questions/question_model.dart';

import '../../../../core/provider.dart';
import '../comment_model.dart';

class CommentProvider extends Provider<Comment> {
  Future<bool?> approve(Question question, Comment comment) async {
    var res = await sendRequest(
        'questions/${question.id}/comments/${comment.id}/approve', "GET");
    return res.bodyString == "1";
  }

  Future<bool?> disApprove(Question question, Comment comment) async {
    var res = await sendRequest(
        'questions/${question.id}/comments/${comment.id}/disApprove', "GET");
    return res.bodyString == "1";
  }

  @override
  fromJsonModel(json) => Comment.fromJson(json);
}
