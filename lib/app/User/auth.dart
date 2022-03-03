import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:learnify_client/app/User/user_model.dart';

class Auth {
  static RxBool _authenticated = false.obs;
  static Rx<User> _user = Rx<User>(User());
  static bool get authenticated => _authenticated.value;
  static User get user => _user.value;
  static set authenticated(value) => _authenticated.value = value;
  static set user(user) => _user.value = user;
}
