import '../../../../core/provider.dart';
import '../comment_model.dart';

class CommentProvider extends Provider<Comment> {
  @override
  fromJsonModel(json) => Comment.fromJson(json);
}
