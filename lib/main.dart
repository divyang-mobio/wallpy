import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controllers/search_bloc.dart';
import 'controllers/favorite_bloc.dart';
import 'screens/detail_screen.dart';
import 'models/navigation_model.dart';
import 'screens/bottom_navigation_screen.dart';
import 'controllers/data_fetch_bloc.dart';
import 'utils/firestore_database_calling.dart';
import 'screens/splash_screen.dart';
import 'resources/resources.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();
  // NotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = TextResources().splashScreenRoute;

  @override
  void initState() {
    super.initState();

    /// open app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        final route = event.data["route"];
        print(route);
        if (route.toString() == "2") {
          initialRoute == TextResources().homeScreenRoute;
        }
      }
    });

    /// foreground Work notification
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        print(event.notification?.title);
        // NotificationService.display(event);
      }
    });

    /// only work when app is in recent
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final route = event.data["route"];
      print(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<FirebaseDatabase>(
      create: (context) => (FirebaseDatabase()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DataFetchBloc>(
            create: (context) =>
                DataFetchBloc(RepositoryProvider.of<FirebaseDatabase>(context))
                  ..add(GetAllData(isFavorite: false, category: null)),
          ),
          BlocProvider<FavoriteBloc>(
              create: (context) => FavoriteBloc(FirebaseDatabase())
                ..add(GetFavoriteData(isFavorite: true, category: null))),
          BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: TextResources().appTitle,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                  subtitle1: TextStyle(color: ColorResources().categoryText),
                  headline1: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: ColorResources().splashWord)),
            ),
            onGenerateRoute: (RouteSettings setting) {
              switch (setting.name) {
                case "/":
                  return MaterialPageRoute(
                      builder: (context) => const SplashScreen());
                case "/bottomBar":
                  return MaterialPageRoute(
                      builder: (context) => const BottomNavigationBarScreen());
                case "/detail":
                  final args = setting.arguments as DetailScreenArgument;
                  return MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(dataModel: args.dataModel));
                default:
                  return MaterialPageRoute(
                      builder: (context) => const BottomNavigationBarScreen());
              }
            },
            initialRoute: initialRoute //TextResources().splashScreenRoute,
            ),
      ),
    );
  }
}
