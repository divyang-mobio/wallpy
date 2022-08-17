import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings();
    _notificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    final id = DateTime.now().microsecondsSinceEpoch ~/ 1000;
    const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails("wallpy", "wallpy_channel",
            importance: Importance.max, priority: Priority.high));
    await _notificationsPlugin.show(id, message.notification?.title,
        message.notification?.body, notificationDetails);
  }
}
