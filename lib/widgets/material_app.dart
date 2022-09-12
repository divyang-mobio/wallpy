import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:oktoast/oktoast.dart';
import 'route.dart';
import 'theme.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../resources/resources.dart';

class MaterialAppClass extends StatefulWidget {
  const MaterialAppClass({Key? key}) : super(key: key);

  @override
  State<MaterialAppClass> createState() => _MaterialAppClassState();
}

class _MaterialAppClassState extends State<MaterialAppClass> {
  final String initialRoute = TextResources().redirectScreen;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DarkModeBloc, DarkModeState>(builder: (context, state) {
      if (state is DarkModeLoaded) {
        return OKToast(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: TextResources().appTitle,
              themeMode: state.themeMode,
              darkTheme: MyTheme.darkTheme,
              theme: MyTheme.lightTheme,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: initialRoute),
        );
      } else {
        return OKToast(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: TextResources().appTitle,
              themeMode: ThemeMode.light,
              darkTheme: MyTheme.darkTheme,
              theme: MyTheme.lightTheme,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: initialRoute),
        );
      }
    });
  }
}
