import 'package:learnify_client/app/modules/home/vote_model.dart';
import 'package:learnify_client/core/model.dart';

import '../../User/user_model.dart';

class Comment extends Model {
  int? id;
  String? title;
  String? body;
  int? userId;
  int? voteCount;
  String? commentableType;
  int? commentableId;
  bool canApprove = false;
  bool isValid = false;
  String? createdAt;
  String? updatedAt;
  User? user;
  List<Vote> votes = [];

  Comment(
      {this.id,
      this.title,
      this.body,
      this.userId,
      this.voteCount,
      this.commentableType,
      this.commentableId,
      this.createdAt,
      this.updatedAt,
      this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    userId = json['user_id'];
    voteCount = json['voteCount'];
    commentableType = json['commentable_type'];
    commentableId = json['commentable_id'];
    canApprove = json['canApprove'] ?? false;
    isValid = json['isValid'] == 1;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    var res = json['votes'] != null
        ? json['votes'].map((item) => Vote.fromJson(item)).toList()
        : [];

    votes = List<Vote>.from(res);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['user_id'] = userId;
    data['voteCount'] = voteCount;
    data['commentable_type'] = commentableType;
    data['commentable_id'] = commentableId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    return data;
  }
}
