import 'package:flutter/material.dart';
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
    await Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
        Navigator.pushReplacementNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          TextResources().appTitle,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
