import 'dart:math';

import 'package:learnify_client/core/model.dart';

class User extends Model {
  int? id;
  String? reputation;
  String? name;
  String? points;
  String? email;
  String? token = '';
  String alt2 = 'test';
  String? password;
  int questions_count = 0;
  int comments_count = 0;
  int rooms_count = 0;
  int valid_comments_count = 0;
  int owned_rooms_count = 0;
  dynamic emailVerifiedAt;
  int? type;
  String? createdAt;
  String? updatedAt;
  int? imageId;
  List<Badges> badges = [];
  static const userType = {'0': "Teacher", '1': "Student"};

  bool isRecommended = false;
  String get alt => "$name $alt2";
  int get rank {
    int points = int.tryParse(this.points!)!;
    double rank = sqrt(points) / 3;
    return rank.floor();
  }

  int requiredPoints(int rank) {
    return 9 * rank * rank;
  }

  int get remainingPoints {
    int points = int.tryParse(this.points!)!;
    return requiredPoints(rank + 1) - points;
  }

  User(
      {this.id,
      this.reputation,
      this.points,
      this.name,
      this.email,
      this.password,
      this.emailVerifiedAt,
      this.type,
      this.createdAt,
      this.imageId,
      this.updatedAt});

  @override
  String toString() {
    return 'User{id: $id,id: $reputation, name: $points,name: $name, email: $email, token: $token, password: $password, emailVerifiedAt: $emailVerifiedAt, type: $type, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['reputation'] is int)
      json['reputation'] = json['reputation'].toString();
    reputation = (json['reputation'] as String?) ?? '0';
    points = json['points'] ?? '0';
    name = json['name'];
    email = json['email'];
    token = json['token'];
    password = json['password'];
    questions_count = json['questions_count'] ?? 0;
    comments_count = json['comments_count'] ?? 0;
    rooms_count = json['rooms_count'] ?? 0;
    valid_comments_count = json['valid_comments_count'] ?? 0;
    owned_rooms_count = json['owned_rooms_count'] ?? 0;
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    isRecommended = json['isRecommended'] ?? false;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageId = json['imageId'];
    badges = json['badges'] == null
        ? []
        : List<Badges>.from(json['badges'].map((item) {
            return Badges.fromJson(item);
          }).toList());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['reputation'] = reputation;
    data['points'] = points;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    data['password'] = password;
    data['email_verified_at'] = emailVerifiedAt;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Badges {
  int? id;
  String? name;
  String? description;
  String? icon;
  int? level;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Badges(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.level,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Badges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['level'] = this.level;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? userId;
  int? badgeId;
  String? createdAt;
  String? updatedAt;

  Pivot({this.userId, this.badgeId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    badgeId = json['badge_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['badge_id'] = this.badgeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
