import 'package:learnify_client/core/model.dart';

class Image extends Model {
  String? imagableType;
  String? imagableId;
  String? src;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Image(
      {this.imagableType,
      this.imagableId,
      this.src,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Image.fromJson(Map<String, dynamic> json) {
    imagableType = json['imagable_type'];
    imagableId = json['imagable_id'];
    src = json['src'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagable_type'] = this.imagableType;
    data['imagable_id'] = this.imagableId;
    data['src'] = this.src;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
