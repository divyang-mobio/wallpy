import 'package:flutter/material.dart';
import 'package:wallpy/resources/resources.dart';

// ignore: must_be_immutable
class WelcomeBackgroundWidget extends StatelessWidget {
  String title;
  WelcomeBackgroundWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(150, 7, 70, 40),
              ColorResources().welcomeBackgroundColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline3!.copyWith(
              color: ColorResources().textColorwhite,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
