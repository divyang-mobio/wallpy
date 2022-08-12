import 'package:flutter/material.dart';
import 'package:wallpy/resources/resources.dart';
import 'package:wallpy/widgets/welcome_background_widget.dart';
import '../widgets/sign_in_up_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              ImageResources().welcomeImage,
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
              WelcomeBackgroundWidget(
                title: TextResources().splashScreenTile,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                TextResources().welcomeSubtitle,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: ColorResources().textColorwhite),
              ),
              const SizedBox(
                height: 20,
              ),
              SignInUpButton(
                  text: TextResources().signUp,
                  color: ColorResources().signInButton,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TextResources().signUpScreenRoute,
                    );
                  }),
              SignInUpButton(
                  text: TextResources().signIn,
                  textColor: ColorResources().textColorwhite,
                  color: ColorResources().signUpButton,
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
}
