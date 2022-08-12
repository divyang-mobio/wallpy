import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallpy/controllers/news_data_fetch_bloc.dart';
import 'package:wallpy/screens/search_screen.dart';
import 'package:wallpy/utils/auth_repository.dart';
import 'package:wallpy/screens/main_screen.dart';
import 'package:wallpy/screens/sign_in_screen.dart';
import 'package:wallpy/screens/sign_up_screen.dart';
import 'package:wallpy/screens/welcome_screen.dart';
import 'package:wallpy/utils/news_api_calling.dart';
import 'controllers/auth_bloc/auth_bloc_bloc.dart';
import 'controllers/favorite_bloc/favorite_bloc.dart';
import 'controllers/search_bloc.dart';
import 'screens/detail_news_screen.dart';
import 'screens/detail_screen.dart';
import 'models/navigation_model.dart';
import 'screens/bottom_navigation_screen.dart';
import 'controllers/data_fetch_bloc/data_fetch_bloc.dart';
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseDatabase>(
            create: (context) => (FirebaseDatabase())),
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<GoogleSignIn>(
          create: (context) => GoogleSignIn(),
        ),
        RepositoryProvider<HttpService>(
          create: (context) => HttpService(),
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
          BlocProvider<NewsDataFetchBloc>(
              create: (context) =>
                  NewsDataFetchBloc(RepositoryProvider.of<HttpService>(context))
                    ..add(GetAllNewsData(url: TextResources().url))),
          BlocProvider<AuthBlocBloc>(
            create: (context) => AuthBlocBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                googleSignIn: RepositoryProvider.of<GoogleSignIn>(context)),
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
                case "/detailNews":
                  final args = setting.arguments as DetailNewsScreenArgument;
                  return MaterialPageRoute(
                      builder: (context) =>
                          DetailNewsScreen(articles: args.articles));
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
