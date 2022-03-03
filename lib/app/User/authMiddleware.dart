import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'auth.dart';

class AuthMiddleware extends GetMiddleware {
  bool check = false;

  @override
  RouteSettings? redirect(String? route) {
    if (Auth.authenticated || route == '/register' || route == '/login')
      return null;
    return const RouteSettings(name: '/login');
  }
}
