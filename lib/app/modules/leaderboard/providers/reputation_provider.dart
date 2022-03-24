import 'package:get/get.dart';
import 'package:learnify_client/core/provider.dart';

import '../reputation_model.dart';

class ReputationProvider extends Provider<Reputation> {
  @override
  fromJsonModel(json) => Reputation.fromJson(json);
}
