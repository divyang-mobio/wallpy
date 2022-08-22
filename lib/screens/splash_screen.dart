import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpy/screens/bottom_navigation_screen.dart';
import 'package:wallpy/screens/main_screen.dart';
import 'package:wallpy/screens/redirect_screen.dart';
import 'package:wallpy/screens/welcome_screen.dart';
import '../widgets/theme.dart';
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
        Navigator.popAndPushNamed(context, TextResources().redirectScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          TextResources().splashScreenTile,
          style: Theme.of(context).textTheme.headline1?.copyWith(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? ColorResources().splashWordDark
                  : ColorResources().splashWord),
        ),
      ),
    );
  }
}
