import 'package:learnify_client/core/model.dart';

class User extends Model {
  int? id;
  String? reputation;
  String? name;
  String? points;
  String? email;
  String? token = '';
  String? password;
  dynamic emailVerifiedAt;
  int? type;
  String? createdAt;
  String? updatedAt;
  int? imageId;
  static const userType = {'0': "Teacher", '1': "Student"};
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
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageId = json['imageId'];
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
