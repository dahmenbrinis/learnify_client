import 'package:learnify_client/core/model.dart';

class DBNotification extends Model {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  String? body;
  String? title;
  String? readAt;
  String? createdAt;
  String? updatedAt;
  Notification? data;

  DBNotification(
      {this.id,
      this.type,
      this.notifiableType,
      this.notifiableId,
      this.body,
      this.title,
      this.readAt,
      this.createdAt,
      this.updatedAt,
      this.data});

  DBNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    body = json['body'];
    title = json['title'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    data =
        json['data'] != null ? new Notification.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    data['body'] = this.body;
    data['title'] = this.title;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Notification {
  String? title;
  String? body;
  String? type;
  Notification get enhanced {
    var notification = Notification(type: type);
    switch (type) {
      case 'App\\Notifications\\NewCommentNotification':
        notification.title = title! + ' commented on your question';
        notification.body = 'says : ' + body!;
        return notification;
      case 'App\\Notifications\\QuestionAdded':
        notification.title = title! + ' posted a question';
        notification.body = 'says : ' + body!;
        return notification;

      case 'App\\Notifications\\CommentVoted':
        notification.title = title! + ' liked your comment';
        notification.body = title! + ' liked this comment: \n' + body!;
        return notification;
      case 'App\\Notifications\\newSubscriber':
        notification.title = 'new subscriber';
        notification.body = title! + ' subscribed to your room : ' + body!;
        return notification;
      case 'App\\Notifications\\SubscriberLeft':
        notification.title = 'subscriber left';
        notification.body = title! + ' left your room : ' + body!;
        return notification;
      case 'App\\Notifications\\QuestionVoted':
        notification.title = title! + ' liked your question';
        notification.body = title! +
            ' supported you with a vote on this question: \n' +
            this.body!;
        return notification;
      case 'App\\Notifications\\Welcome':
        notification.title = 'login notice';
        notification.body = 'you have made a successful authentication';
        return notification;
      case 'App\\Notifications\\NewBadgeReceived':
        notification.title = 'Hurray :)';
        notification.body = 'you have got a new badge \n--> $body <--';
        return notification;
    }
    return this;
  }

  Notification({this.title, this.body, this.type});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    return data;
  }
}
