import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
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
              color: BlocProvider.of<DarkModeBloc>(context).isDark
                  ? ColorResources().splashWordDark
                  : ColorResources().splashWord),
        ),
      ),
    );
  }
}
