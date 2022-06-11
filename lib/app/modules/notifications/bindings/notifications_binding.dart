import 'package:get/get.dart';
import 'package:learnify_client/app/modules/notifications/notification_provider.dart';

import '../controllers/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationProvider>(() => NotificationProvider());
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}
