import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/core/model.dart';

class Reputation extends Model {
  int? id;
  String? name;
  String? points;
  int? subjectId;
  String? subjectType;
  int? payeeId;
  String? meta;
  String? createdAt;
  String? updatedAt;
  late User payee;

  Reputation(
      {this.id,
      this.name,
      this.points,
      this.subjectId,
      this.subjectType,
      this.payeeId,
      this.meta,
      this.createdAt,
      this.updatedAt,
      required this.payee});

  Reputation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    points = json['points'];
    subjectId = json['subject_id'];
    subjectType = json['subject_type'];
    payeeId = json['payee_id'];
    meta = json['meta'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    payee = json['payee'] != null ? User?.fromJson(json['payee']) : User();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['point'] = points;
    data['subject_id'] = subjectId;
    data['subject_type'] = subjectType;
    data['payee_id'] = payeeId;
    data['meta'] = meta;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (payee != null) {
      data['payee'] = payee.toJson();
    }
    return data;
  }
}
