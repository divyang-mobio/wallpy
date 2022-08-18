import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallpy/controllers/category_bloc/category_bloc.dart';
import 'package:wallpy/controllers/weather_bloc/weather_bloc.dart';
import 'package:wallpy/models/weather_model.dart';
import 'package:wallpy/screens/search_screen.dart';
import 'package:wallpy/utils/auth_repository.dart';
import 'package:wallpy/screens/main_screen.dart';
import 'package:wallpy/screens/sign_in_screen.dart';
import 'package:wallpy/screens/sign_up_screen.dart';
import 'package:wallpy/screens/welcome_screen.dart';
import 'package:wallpy/utils/http_requets.dart';
import 'package:wallpy/utils/notification.dart';
import 'package:workmanager/workmanager.dart';
import 'controllers/auth_bloc/auth_bloc_bloc.dart';
import 'controllers/favorite_bloc/favorite_bloc.dart';
import 'controllers/search_bloc.dart';
import 'screens/detail_screen.dart';
import 'models/navigation_model.dart';
import 'screens/bottom_navigation_screen.dart';
import 'controllers/data_fetch_bloc/data_fetch_bloc.dart';
import 'utils/firestore_database_calling.dart';
import 'screens/splash_screen.dart';
import 'resources/resources.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();

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
        // ignore: avoid_print
        print(route);
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
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseDatabase>(
            create: (context) => (FirebaseDatabase())),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<GoogleSignIn>(
          create: (context) => GoogleSignIn(),
        ),
        RepositoryProvider<HttpRequests>(
          create: (context) => HttpRequests(),
        ),
      ],
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
          BlocProvider<AuthBlocBloc>(
            create: (context) => AuthBlocBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                googleSignIn: RepositoryProvider.of<GoogleSignIn>(context)),
          ),
          BlocProvider<CategoryBloc>(
            create: (context) =>
                CategoryBloc(RepositoryProvider.of<FirebaseDatabase>(context))
                  ..add(const GetAllCategory(category: [])),
          ),
          BlocProvider<WeatherBloc>(
            create: (context) =>
                WeatherBloc(RepositoryProvider.of<HttpRequests>(context))
                  ..add(const GetAllWeather(weather: null)),
          ),
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
                case "/search":
                  final args = setting.arguments as SearchScreenArgument;
                  return MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(screen: args.selectedScreen));
                case "/welcome":
                  return MaterialPageRoute(
                      builder: (context) => const WelcomeScreen());
                case "/signUp":
                  return MaterialPageRoute(
                      builder: (context) => const SignUp());
                case "/signIn":
                  return MaterialPageRoute(
                      builder: (context) => const SignIn());
                default:
                  return MaterialPageRoute(
                      builder: (context) => const MyHomePage());
              }
            },
            initialRoute: initialRoute),
      ),
    );
  }
}
