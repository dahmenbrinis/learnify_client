import 'package:get/get.dart';

import '../image_model.dart';

class ImageProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Image.fromJson(map);
      if (map is List) return map.map((item) => Image.fromJson(item)).toList();
    };
  }
}
