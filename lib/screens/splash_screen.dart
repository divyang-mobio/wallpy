import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigation();
  }

  void _navigation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool isAuth = preferences.getBool("isLogin") ?? false;

    await Future.delayed(const Duration(seconds: 1)).whenComplete(() =>
        Navigator.pushReplacementNamed(context,
            isAuth ? "/bottomBar" : TextResources().welcomeScreenRoute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          TextResources().splashScreenTile,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
