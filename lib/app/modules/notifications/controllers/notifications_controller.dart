import 'package:get/get.dart';
import 'package:learnify_client/app/modules/notifications/database_notification_model.dart';
import 'package:learnify_client/app/modules/notifications/notification_provider.dart';
import 'package:learnify_client/core/pagination.dart';

class NotificationsController extends GetxController {
  //TODO: Implement NotificationsController
  final list = Rx(Paginated<DBNotification>());
  final isLoading = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  fetch({reload = true}) async {
    if (isLoading.isTrue) return;
    isLoading(true);
    if (reload) list.value.init();
    var res = await Get.find<NotificationProvider>()
        .index('notification/index', page: list.value.next_page);
    if (res != null) {
      list.value.addAll(res);
      list.refresh();
      count.value =
          list.value.data.where((element) => element.readAt == null).length;
    }
    isLoading(false);
  }

  var isMarking = false.obs;
  markAsRead() async {
    if (isMarking.isTrue) return;
    isMarking(true);
    var res = await Get.find<NotificationProvider>()
        .sendRequest('notification/mark_read', 'POST');
    isMarking(false);
    if (res.bodyString == "1") {
      fetch();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
