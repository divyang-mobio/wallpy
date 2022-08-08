import 'package:flutter/material.dart';
import 'package:wallpy/resources/resources.dart';
import 'package:wallpy/utils/firebase_auth_methods.dart';
import '../widgets/sign_in_up_button.dart';
import '../widgets/textfield_widget.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController textController = TextEditingController();

  bool hidePassword = true;

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
              child: Image.asset(
                'assets/images/welcome3.jpg',
                fit: BoxFit.fill,
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility_off_rounded),
                      onPressed: () {},
                    )),
                const SizedBox(
                  height: 40,
                ),
                SignInUpButton(
                    text: 'Sign-Up',
                    color: Colors.amber,
                    onTap: () async {
                      await FireBaseAuthMethods.signUpWithEmail(
                          textController.text, passController.text, context);
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
                      Navigator.pushReplacementNamed(
                        context,
                        TextResources().signInScreenRoute,
                      );
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
