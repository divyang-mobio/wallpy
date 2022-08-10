import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpy/controllers/auth_bloc/auth_bloc_bloc.dart';
import 'package:wallpy/resources/resources.dart';
import 'package:wallpy/utils/validators.dart';
import 'package:wallpy/widgets/welcome_background_widget.dart';
import '../widgets/sign_in_up_button.dart';
import '../widgets/textfield_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    passController.dispose();
    super.dispose();
  }

  _authenticateWithEmailAndPassword(context) {
    BlocProvider.of<AuthBlocBloc>(context).add(
      SignInRequested(textController.text, passController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                ImageResources().welcomeImage,
              ))),
      child: Scaffold(
        backgroundColor: ColorResources().welcomeBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocListener<AuthBlocBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is Authenticated) {
                Navigator.popAndPushNamed(
                  context,
                  TextResources().homeScreenRoute,
                );
              }
              if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            child: BlocBuilder<AuthBlocBloc, AuthBlocState>(
                builder: (context, state) {
              if (state is AuthBlocInitial) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorResources().circularProgress,
                  ),
                );
              }
              if (state is UnAuthenticated) {
                return Center(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          WelcomeBackgroundWidget(
                              title: TextResources().signInTitle),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormFieldCustom(
                            textcontroller: textController,
                            isPasswordText: false,
                            prefixIcon: Icon(IconsResources().email,
                                color: ColorResources().appBarTextIcon),
                            hintText: TextResources().email,
                            validator: (value) =>
                                Validator.validateEmail(email: value!),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormFieldCustom(
                            textcontroller: passController,
                            isPasswordText: true,
                            prefixIcon: Icon(IconsResources().lock,
                                color: ColorResources().appBarTextIcon),
                            hintText: TextResources().password,
                            validator: (value) =>
                                Validator.validatePassword(password: value),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SignInUpButton(
                              text: TextResources().signIn,
                              color: ColorResources().signInButton,
                              onTap: () async {
                                await _authenticateWithEmailAndPassword(
                                    context);
                              }),
                          Center(
                              child: Text(
                            TextResources().or,
                            style: TextStyle(
                              color: ColorResources().appBar,
                            ),
                          )),
                          SignInUpButton(
                              text: TextResources().signUp,
                              textColor: ColorResources().appBar,
                              color: ColorResources().signUpButton,
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  TextResources().signUpScreenRoute,
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }),
          ),
        ),
      ),
    );
  }
}
