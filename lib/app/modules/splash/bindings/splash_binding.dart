import 'package:get/get.dart';

import '../../../User/AuthController.dart';
import '../../../User/user_provider.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
