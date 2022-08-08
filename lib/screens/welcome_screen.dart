// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallpy/resources/resources.dart';
import 'package:wallpy/screens/sign_in_screen.dart';
import 'package:wallpy/screens/sign_up_screen.dart';

import '../widgets/sign_in_up_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.amber,
            child: Image.asset(
              'assets/images/welcome3.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
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
                TextResources().welcomSubtitle,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              SignInUpButton(
                  text: TextResources().signUp,
                  color: Colors.amber,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TextResources().signUpScreenRoute,
                    );
                  }),
              SignInUpButton(
                  text: TextResources().signIn,
                  textColor: Colors.white,
                  color: Color.fromARGB(106, 255, 255, 255),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TextResources().signInScreenRoute,
                    );
                  })
            ],
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
          TextResources().splashScreenTile,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
