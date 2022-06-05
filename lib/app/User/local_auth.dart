import '../../core/local_storage.dart';

class Authentication {
  static String? authToken;
  static int? userId;
  static String? userFullName;
  static String? userPhone;

  static bool? auth;

  void login(String authToken, userId, userFullName, userPhone) {
    Authentication.authToken = authToken;
    LocalStorage().save('authToken', authToken);
    Authentication.userId = userId;
    LocalStorage().save('userId', userId.toString());
    Authentication.userFullName = userFullName;
    LocalStorage().save('userFullName', userFullName);
    Authentication.userPhone = userPhone;
    LocalStorage().save('userPhone', userPhone);
    auth = true;
  }

  void update(String authToken, userId, userFullName, userPhone) {
    Authentication.authToken = authToken;
    LocalStorage().save('authToken', authToken);
    Authentication.userId = userId;
    LocalStorage().save('userId', userId.toString());
    Authentication.userFullName = userFullName;
    LocalStorage().save('userFullName', userFullName);
    Authentication.userPhone = userPhone;
    LocalStorage().save('userPhone', userPhone);
    auth = true;
  }

  void logout() {
    LocalStorage().delete('authToken');
    LocalStorage().delete('userId');
    LocalStorage().delete('userFullName');
    LocalStorage().delete('userPhone');
    authToken = null;
    userFullName = null;
    userPhone = null;
    auth = false;
  }

  Future<bool> isLogged() async {
    if (await LocalStorage().isSaved('authToken')) {
      authToken = await LocalStorage().read('authToken');
      String? userIdStr = await LocalStorage().read('userId');
      userId = double.parse(userIdStr!).toInt();
      userFullName = await LocalStorage().read('userFullName');
      userPhone = await LocalStorage().read('userPhone');
      auth = true;
      return true;
    } else {
      auth = false;
      return false;
    }
  }
}
