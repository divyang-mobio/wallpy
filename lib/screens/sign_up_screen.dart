import 'package:flutter/material.dart';
import 'package:wallpy/screens/sign_in_screen.dart';
import 'package:wallpy/utils/firebase_auth_methods.dart';

import '../widgets/sign_in_up_button.dart';
import '../widgets/textfield_widget.dart';
import 'bottom_navigation_screen.dart';
import 'main_screen.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  TextEditingController textController = TextEditingController();

  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.amber,
              child: Positioned(
                // bottom: 10,
                child: Image.asset(
                  'assets/images/welcome3.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(context),
                const SizedBox(
                  height: 50,
                ),
                Textfield(
                  controller: textController,
                  icon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                Textfield(
                  controller: passController,
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  hint: 'Password',
                  suffixIcon: Icon(Icons.visibility_off_rounded),
                ),
                const SizedBox(
                  height: 40,
                ),
                SignInUpButton(
                    text: 'Sign-Up',
                    color: Colors.amber,
                    onTap: () async {
                      try {
                        FireBaseAuthMethods().startLoader(context);
                        final newUser =
                            await FireBaseAuthMethods.signUpWithEmail(
                                textController.text, passController.text);
                        if (newUser != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const BottomNavigationBarScreen();
                          }));
                          SnackBar(content: Text('SignUp Successfully!'));
                        } else {
                          FireBaseAuthMethods().closeLoader();
                          SnackBar(content: Text('Something went wrong!'));
                        }
                      } catch (e) {
                        FireBaseAuthMethods().closeLoader();
                        print(e.toString());
                        SnackBar(content: Text(e.toString()));
                      }
                    }),
                const Center(
                    child: Text(
                  'OR',
                  style: TextStyle(color: Colors.white),
                )),
                SignInUpButton(
                    text: 'Sign-In',
                    textColor: Colors.white,
                    color: Color.fromARGB(106, 255, 255, 255),
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return SignIn();
                      // }));
                    })
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Container title(BuildContext context) {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(150, 7, 70, 40), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),

          //color: Color.fromARGB(150, 7, 70, 40),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Create Account',
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
