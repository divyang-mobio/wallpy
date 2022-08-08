// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallpy/screens/sign_in_screen.dart';
import 'package:wallpy/screens/sign_up_screen.dart';

import '../widgets/sign_in_up_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.amber,
          child: Positioned(
            child: Image.asset(
              'assets/images/welcome3.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                wallpyWidget(context),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Walpy does not rely on fixed-time alarms that prevent your device from getting enough sleep. It lets Android figure out when is the best time to change wallpapers. You can configure constraints to only change wallpaper while your device is:',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                SignInUpButton(
                    text: 'Sign-Up',
                    color: Colors.amber,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUp();
                      }));
                    }),
                SignInUpButton(
                    text: 'Sign-In',
                    textColor: Colors.white,
                    color: Color.fromARGB(106, 255, 255, 255),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignIn();
                      }));
                    })
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Container wallpyWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [Color.fromARGB(150, 7, 70, 40), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Wallpy',
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
