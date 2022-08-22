import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wallpy/controllers/auth_bloc/auth_bloc_bloc.dart';
import 'package:wallpy/resources/resources.dart';
import 'package:wallpy/widgets/welcome_background_widget.dart';
import '../utils/validators.dart';
import '../widgets/sign_in_up_button.dart';
import '../widgets/textfield_widget.dart';
import '../widgets/theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController textController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBlocBloc>(context).add(
        SignUpRequested(
            textController.text, passController.text, nameController.text),
      );
    }
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
                child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
                    listener: (context, state) {
                  if (state is Authenticated) {
                    Navigator.popAndPushNamed(
                        context, TextResources().homeScreenRoute);
                    return;
                  }
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                    return;
                  }
                }, builder: (context, state) {
                  if (state is AuthBlocInitial) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? ColorResources().circularProgressDark
                            : ColorResources().circularProgress,
                      ),
                    );
                  }
                  if (state is UnAuthenticated) {
                    return Form(
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
                                title: TextResources().signUpTitle),
                            const SizedBox(
                              height: 50,
                            ),
                            TextFormFieldCustom(
                              textController: nameController,
                              isPasswordText: false,
                              prefixIcon: Icon(IconsResources().user,
                                  color: ColorResources().appBarTextIcon),
                              hintText: TextResources().name,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormFieldCustom(
                              textController: textController,
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
                              textController: passController,
                              isPasswordText: true,
                              prefixIcon: Icon(IconsResources().lock,
                                  color: ColorResources().appBarTextIcon),
                              hintText: TextResources().password,
                              validator: (value) =>
                                  Validator.validatePassword(password: value!),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SignInUpButton(
                              text: TextResources().signUp,
                              color: ColorResources().signInButton,
                              onTap: () async {
                                await _authenticateWithEmailAndPassword(
                                    context);
                              },
                            ),
                            Center(
                                child: Text(
                              TextResources().or,
                              style: TextStyle(color: ColorResources().appBar),
                            )),
                            SignInUpButton(
                                text: TextResources().signIn,
                                textColor: ColorResources().appBar,
                                color: ColorResources().signUpButton,
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    TextResources().signInScreenRoute,
                                  );
                                }),
                            SignInUpButton(
                                text: TextResources().googleSignInUp,
                                textColor: ColorResources().googleSignInUpText,
                                color: ColorResources().signUpButton,
                                onTap: () {
                                  BlocProvider.of<AuthBlocBloc>(context)
                                      .add(GoogleSignUpRequested());
                                })
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }))));
  }
}
