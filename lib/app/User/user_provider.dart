import 'package:get/get.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/utils.dart';
import 'AuthController.dart';

class UserProvider extends GetConnect {
  String get token => Get.find<AuthController>().user.token as String;
  get headers => token.isEmpty
      ? {'Accept': 'application/json'}
      : {'Authorization': "Bearer $token", 'Accept': 'application/json'};

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return User.fromJson(map);
      if (map is List) return map.map((item) => User.fromJson(item)).toList();
    };
    httpClient.baseUrl = Utils.baseUrl;
    httpClient.defaultContentType = "application/json";
  }

  Future<User?> getUser(int id) async {
    final response = await get('/api/user/$id');
    return response.body;
  }

  Future<User?> getAuth(String? token) async {
    final response = await post('/api/test', {}, headers: headers);
    return response.body;
  }

  Future<Response<User>> postUser(User user) async =>
      await post('api/user', user, headers: headers);
  Future<Response> deleteUser(int id) async =>
      await delete('/api/user/$id', headers: headers);
}
