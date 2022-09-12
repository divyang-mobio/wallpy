import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:wallpy/widgets/repository.dart';
import 'models/weather_model.dart';
import 'utils/http_requets.dart';
import 'utils/notification.dart';
import 'package:workmanager/workmanager.dart';
import 'resources/resources.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data);
}

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        WeatherApiResModel weatherData =
            await HttpRequests().determinePosition();
        NotificationClass()
            .showNotificationWithoutSound(weatherData: weatherData);
        break;
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = TextResources().splashScreenRoute;

  initialized() async {
    await HttpRequests().reqPermission();
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    Workmanager().registerPeriodicTask(
      "1",
      fetchBackground,
      frequency: const Duration(minutes: 15),
    );
    // NotificationService.initialize();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  @override
  void initState() {
    super.initState();

    initialized();
    firebaseMessaging();
  }

  firebaseMessaging() {
    /// open app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        final route = event.data["route"];
        if (route.toString() == "2") {
          initialRoute == TextResources().homeScreenRoute;
        }
      }
    });

    /// foreground Work notification
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        // ignore: avoid_print
        print(event.notification?.title);
        // NotificationService.display(event);
      }
    });

    /// only work when app is in recent
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final route = event.data["route"];
      // ignore: avoid_print
      print(route);
    });
  }

  @override
  Widget build(BuildContext context) => const RepositoryClass();
}
