import 'package:learnify_client/core/provider.dart';

import '../vote_model.dart';

class VoteProvider extends Provider<Vote> {
  Future<Vote?> vote(int id, String modelName, int roomId) async {
    var res = await sendRequest('vote', "POST", body: {
      'votable_id': id.toString(),
      'votable_type': 'App\\Models\\${modelName}',
      'room': roomId,
    });
    return res.body;
  }

  Future<bool> unVote(int id, String modelName, int roomId) async {
    var res = await sendRequest('unVote', "POST", body: {
      'votable_id': id.toString(),
      'votable_type': 'App\\Models\\${modelName}',
      'room': roomId,
    });
    return res.bodyString == "1";
  }

  @override
  fromJsonModel(json) => Vote.fromJson(json);
}
