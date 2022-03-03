import 'package:get/get.dart';
import '../../../User/auth.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() {
    count.value++;
    Auth.user.name = 'hes${count.value}';
  }
}
