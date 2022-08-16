import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:wallpy/models/weather_model.dart';

class NotificationClass extends Notification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future showNotificationWithoutSound(
      {required WeatherApiResModel weatherData}) async {
    // ignore: unnecessary_new
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        '1', 'location-bg',
        playSound: false, importance: Importance.max, priority: Priority.high);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      1,

      weatherData.name,
      weatherData.main?.temp.toString(),
      //position.toString(),
      platformChannelSpecifics,
      payload: '',
    );
  }

  NotificationClass() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
