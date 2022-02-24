import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';
import 'package:learnify_client/core/model.dart';

class Question extends Model {
  int? id;
  String? title;
  String? description;
  int? roomId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Permissions? permissions;
  int? voteCount;
  int? answersCount;
  User? user;
  Room? room;

  Question(
      {this.id,
      this.title,
      this.description,
      this.roomId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.voteCount,
      this.answersCount,
      this.user,
      this.room});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    roomId = json['room_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    permissions = json['permissions'] != null
        ? Permissions?.fromJson(json['permissions'])
        : null;
    voteCount = json['voteCount'];
    answersCount = json['answersCount'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    room = json['room'] != null ? Room?.fromJson(json['room']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['room_id'] = roomId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (permissions != null) {
      data['permissions'] = permissions?.toJson();
    }
    data['voteCount'] = voteCount;
    data['answersCount'] = answersCount;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    if (room != null) {
      data['room'] = room?.toJson();
    }
    return data;
  }
}

class Permissions {
  bool? canViewAny;
  bool? canView;
  bool? canUpdate;
  bool? canDelete;
  bool? canCreate;

  Permissions(
      {this.canViewAny,
      this.canView,
      this.canUpdate,
      this.canDelete,
      this.canCreate});

  Permissions.fromJson(Map<String, dynamic> json) {
    canViewAny = json['can_viewAny'];
    canView = json['can_view'];
    canUpdate = json['can_update'];
    canDelete = json['can_delete'];
    canCreate = json['can_create'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['can_viewAny'] = canViewAny;
    data['can_view'] = canView;
    data['can_update'] = canUpdate;
    data['can_delete'] = canDelete;
    data['can_create'] = canCreate;
    return data;
  }
}
