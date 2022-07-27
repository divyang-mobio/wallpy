import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallpy/models/navigation_model.dart';
import 'package:wallpy/screens/detail_screen.dart';
import 'package:wallpy/screens/main_screen.dart';
import 'screens/splash_screen.dart';
import 'resources/resources.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TextResources().appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
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
          case "/home":
            return MaterialPageRoute(builder: (context) => const MyHomePage());
          case "/detail":
            final args = setting.arguments as DetailScreenArgument;
            return MaterialPageRoute(
                builder: (context) => DetailScreen(link: args.link));
        }
      },
      initialRoute: '/',
      // home: const SplashScreen(),
    );
  }
}
