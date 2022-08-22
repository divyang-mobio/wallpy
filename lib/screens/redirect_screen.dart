import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wallpy/screens/bottom_navigation_screen.dart';
import 'package:wallpy/screens/welcome_screen.dart';

class RedirectScreen extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  RedirectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fbApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Having an error');
        } else if (snapshot.hasData) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const BottomNavigationBarScreen();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Worng ID , Password")));
                  return const WelcomeScreen();
                } else {
                  return const WelcomeScreen();
                }
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
