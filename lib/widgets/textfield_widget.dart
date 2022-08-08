import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Textfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  Icon icon;
  Icon? suffixIcon;
  Textfield(
      {required this.controller,
      required this.hint,
      required this.icon,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.zero,
          suffixIcon: suffixIcon,
          prefixIcon: icon,
          filled: true,
          fillColor: const Color.fromARGB(166, 255, 255, 255),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
