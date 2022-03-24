import 'package:get/get.dart';
import 'package:learnify_client/app/User/user_model.dart';
import 'package:learnify_client/core/provider.dart';
import 'package:learnify_client/core/utils.dart';
import 'AuthController.dart';

class UserProvider extends Provider<User> {
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

  @override
  fromJsonModel(item) {
    return User.fromJson(item);
  }
}
