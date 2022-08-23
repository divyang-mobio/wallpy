import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallpy/controllers/service_bloc/service_bloc.dart';
import 'package:wallpy/utils/store_data.dart';
import 'package:wallpy/widgets/theme.dart';
import 'controllers/dark_mode_bloc/dark_mode_bloc.dart';
import 'controllers/new_category_bloc/news_category_bloc.dart';
import 'package:wallpy/controllers/news_data_fetch_bloc/news_data_fetch_bloc.dart';
import 'package:wallpy/controllers/category_bloc/category_bloc.dart';
import 'package:wallpy/controllers/weather_bloc/weather_bloc.dart';
import 'package:wallpy/models/weather_model.dart';
import 'package:wallpy/utils/auth_repository.dart';
import 'package:wallpy/utils/news_api_calling.dart';
import 'widgets/route.dart';
import 'package:wallpy/utils/http_requets.dart';
import 'package:wallpy/utils/notification.dart';
import 'package:workmanager/workmanager.dart';
import 'controllers/auth_bloc/auth_bloc_bloc.dart';
import 'controllers/category_bloc/category_bloc.dart';
import 'controllers/favorite_bloc/favorite_bloc.dart';
import 'controllers/search_bloc/search_bloc.dart';
import 'controllers/data_fetch_bloc/data_fetch_bloc.dart';
import 'utils/firestore_database_calling.dart';
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
        RepositoryProvider<HttpService>(
          create: (context) => HttpService(),
        ),
        RepositoryProvider<HttpRequests>(
          create: (context) => HttpRequests(),
        ),
        RepositoryProvider<PreferenceServices>(
          create: (context) => PreferenceServices(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DataFetchBloc>(
            create: (context) =>
                DataFetchBloc(RepositoryProvider.of<FirebaseDatabase>(context))
                  ..add(GetAllData(isFavorite: false, category: null)),
          ),
          BlocProvider<DarkModeBloc>(
            create: (context) =>
                DarkModeBloc(RepositoryProvider.of<PreferenceServices>(context))
                  ..add(Check()),
          ),
          BlocProvider<ServiceBloc>(
              create: (context) => ServiceBloc()
                ..add(CheckService(
                    pref: RepositoryProvider.of<PreferenceServices>(context)))),
          BlocProvider<FavoriteBloc>(
              create: (context) => FavoriteBloc(FirebaseDatabase())
                ..add(GetFavoriteData(isFavorite: true, category: null))),
          BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
          BlocProvider<CategoryBloc>(
            create: (context) =>
                CategoryBloc(RepositoryProvider.of<FirebaseDatabase>(context))
                  ..add(const GetAllCategory(category: [])),
          ),
          BlocProvider<NewsDataFetchBloc>(
              create: (context) =>
                  NewsDataFetchBloc(RepositoryProvider.of<HttpService>(context))
                    ..add(GetAllNewsData(url: TextResources().url))),
          BlocProvider<AuthBlocBloc>(
            create: (context) => AuthBlocBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                googleSignIn: RepositoryProvider.of<GoogleSignIn>(context)),
          ),
          BlocProvider<NewsCategoryBloc>(
              create: (context) => NewsCategoryBloc()),
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
        child:
            // ChangeNotifierProvider<ThemeProvider>(
            //     create: (_) => ThemeProvider()..theme(),
            //     builder: (context, _) {
            //       return
            BlocBuilder<DarkModeBloc, DarkModeState>(builder: (context, state) {
          if (state is DarkModeLoaded) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: TextResources().appTitle,
                themeMode: state.themeMode,
                darkTheme: MyTheme.darkTheme,
                theme: MyTheme.lightTheme,
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: initialRoute);
          } else {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: TextResources().appTitle,
                themeMode: ThemeMode.light,
                darkTheme: MyTheme.darkTheme,
                theme: MyTheme.lightTheme,
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: initialRoute);
          }
          // });
          // return MaterialApp(
          //     debugShowCheckedModeBanner: false,
          //     title: TextResources().appTitle,
          //     themeMode: Provider.of<ThemeProvider>(context).themeMode,
          //     darkTheme: MyTheme.darkTheme,
          //     theme: MyTheme.lightTheme,
          //     onGenerateRoute: RouteGenerator.generateRoute,
          //     //   home:
          //     initialRoute: initialRoute);
        }),
      ),
    );
  }
}
