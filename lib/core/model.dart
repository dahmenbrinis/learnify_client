// ignore_for_file: avoid_print

abstract class Model {
  // Model.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  Model();
}

class ImageModel extends Model {
  int? id;
  String? src;
  String? alt;
  int? userId;
  String? imagableType;
  int? imagableId;
  String? createdAt;
  String? updatedAt;

  ImageModel(
      {this.id,
      this.src,
      this.alt,
      this.userId,
      this.imagableType,
      this.imagableId,
      this.createdAt,
      this.updatedAt});

  @override
  String toString() {
    return '$id';
  }

  ImageModel.fromJson(json) {
    id = json['id'];
    src = json['src'];
    alt = json['alt'];
    userId = json['user_id'];
    imagableType = json['imagable_type'];
    imagableId = json['imagable_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['src'] = src;
    data['alt'] = alt;
    data['user_id'] = userId;
    data['imagable_type'] = imagableType;
    data['imagable_id'] = imagableId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
