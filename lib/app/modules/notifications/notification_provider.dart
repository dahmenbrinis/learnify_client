import 'package:learnify_client/app/modules/notifications/database_notification_model.dart';

import '../../../core/provider.dart';

class NotificationProvider extends Provider<DBNotification> {
  @override
  fromJsonModel(item) => DBNotification.fromJson(item);
}
