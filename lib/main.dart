import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controllers/favorite_bloc.dart';
import 'screens/detail_screen.dart';
import 'models/navigation_model.dart';
import 'screens/bottom_navigation_screen.dart';
import 'controllers/data_fetch_bloc.dart';
import 'utils/firestore_database_calling.dart';
import 'screens/main_screen.dart';
import 'screens/splash_screen.dart';
import 'resources/resources.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<FirebaseDatabase>(
      create: (context) => (FirebaseDatabase()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DataFetchBloc>(
            create: (context) =>
                DataFetchBloc(RepositoryProvider.of<FirebaseDatabase>(context))
                  ..add(GetAllData(
                      isFavorite: false, category: null)),
          ),
          BlocProvider<FavoriteBloc>(
            create: (context) => FavoriteBloc(FirebaseDatabase())
              ..add(GetFavoriteData(
                  isFavorite: true, category: null)),
          ),
        ],
        child: MaterialApp(
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
                    builder: (context) => const MyHomePage());
            }
          },
          initialRoute: TextResources().splashScreenRoute,
        ),
      ),
    );
  }
}
