import 'package:learnify_client/core/model.dart';

import '../../User/user_model.dart';

class Comment extends Model {
  int? id;
  String? title;
  String? body;
  int? userId;
  String? commentableType;
  int? commentableId;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comment(
      {this.id,
      this.title,
      this.body,
      this.userId,
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
    commentableType = json['commentable_type'];
    commentableId = json['commentable_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['user_id'] = userId;
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
