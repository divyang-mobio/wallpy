import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'bottom_navigation_screen.dart';
import 'welcome_screen.dart';

class RedirectScreen extends StatefulWidget {
  const RedirectScreen({Key? key}) : super(key: key);

  @override
  State<RedirectScreen> createState() => _RedirectScreenState();
}

class _RedirectScreenState extends State<RedirectScreen> {
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  void deactivate() {
    super.deactivate();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: _fbApp,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return const Text('Having an error');
    //     } else if (snapshot.hasData) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const BottomNavigationBarScreen();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Worng ID , Password")));
              return const WelcomeScreen();
            } else {
              return const WelcomeScreen();
            }
          }),
    );
    // } else {
    //   return const Center(child: CircularProgressIndicator());
    // }
    //     },
    //   );
  }
}
