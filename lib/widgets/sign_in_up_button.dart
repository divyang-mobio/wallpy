import 'package:flutter/material.dart';

class SignInUpButton extends StatelessWidget {
  final Color color;
  final void Function()? onTap;
  final String text;
  final Color? textColor;
  // ignore: use_key_in_widget_constructors
  const SignInUpButton(
      {required this.color,
      required this.onTap,
      required this.text,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onTap,
        minWidth: MediaQuery.of(context).size.width,
        color: color,
        //color:
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ));
  }
}
