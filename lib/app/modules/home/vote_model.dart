import 'package:learnify_client/core/model.dart';

import '../../User/user_model.dart';

class Vote extends Model {
  int? id;
  dynamic userId;
  int? value;
  String? votableType;
  dynamic votableId;
  String? createdAt;
  String? updatedAt;
  List<User>? user;

  Vote(
      {this.id,
      this.userId,
      this.value,
      this.votableType,
      this.votableId,
      this.createdAt,
      this.updatedAt,
      this.user});

  Vote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    value = json['value'];
    votableType = json['votable_type'];
    votableId = json['votable_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user?.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['value'] = value;
    data['votable_type'] = votableType;
    data['votable_id'] = votableId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
