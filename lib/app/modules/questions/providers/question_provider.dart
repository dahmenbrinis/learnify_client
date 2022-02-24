
import '../../../../core/provider.dart';
import '../question_model.dart';

class QuestionProvider extends Provider<Question> {
  @override
  fromJsonModel(item) => Question.fromJson(item);
}
