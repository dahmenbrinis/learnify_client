import 'package:learnify_client/core/model.dart';

class Room extends Model {
  int? id;
  String? name;
  String? description;
  int? imageId;
  String? code;
  int? visibility;
  int? levelId;
  int? creatorId;
  String? createdAt;
  String? updatedAt;
  Permissions? permissions;
  int? userCount;
  int? questionsCount;
  int? answersCount;
  String? visibilityName;

  var alt2 = 'test';

  Room(
      {this.id,
      this.name,
      this.description,
      this.imageId,
      this.code,
      this.visibility,
      this.levelId,
      this.creatorId,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.userCount,
      this.questionsCount,
      this.answersCount,
      this.visibilityName});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageId = json['imageId'];
    code = json['code'];
    visibility = json['visibility'];
    levelId = json['level_id'];
    creatorId = json['creator_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    permissions = json['permissions'] != null
        ? Permissions.fromJson(json['permissions'])
        : null;
    userCount = json['userCount'];
    questionsCount = json['questionsCount'];
    answersCount = json['answersCount'];
    visibilityName = json['visibilityName'];
  }

  get alt => '$name $alt2';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image_name'] = imageId;
    data['code'] = code;
    data['visibility'] = visibility;
    data['level_id'] = levelId;
    data['creator_id'] = creatorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (permissions != null) {
      data['permissions'] = permissions?.toJson();
    }
    data['userCount'] = userCount;
    data['questionsCount'] = questionsCount;
    data['answersCount'] = answersCount;
    data['visibilityName'] = visibilityName;
    data['XDEBUG_SESSION'] = '1';
    return data;
  }
}

class Permissions {
  bool canViewAny = false;
  bool canView = false;
  bool canUpdate = false;
  bool canDelete = false;
  bool canAsk = false;

  Permissions(
      {this.canViewAny = false,
      this.canView = false,
      this.canUpdate = false,
      this.canDelete = false,
      this.canAsk = false});

  Permissions.fromJson(Map<String, dynamic> json) {
    canViewAny = json['can_viewAny'];
    canView = json['can_view'];
    canUpdate = json['can_update'];
    canDelete = json['can_delete'];
    canAsk = json['can_ask'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['can_viewAny'] = canViewAny;
    data['can_view'] = canView;
    data['can_update'] = canUpdate;
    data['can_delete'] = canDelete;
    data['can_ask'] = canAsk;
    return data;
  }
}
