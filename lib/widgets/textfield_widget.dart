import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpy/resources/resources.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom(
      {Key? key,
      this.onChanged,
      this.validator,
      this.hintText = '',
      this.maxLength,
      this.isPasswordText,
      this.prefixIcon,
      this.suffixIcon,
      this.textController,
      this.inputFormatters})
      : super(key: key);
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool? isPasswordText;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController? textController;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    bool passWordVisible = true;

    return Center(
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        void _togglePasswordVisiblity() {
          setState(() {
            passWordVisible = !passWordVisible;
          });
        }

        return Padding(
          padding: const EdgeInsets.only(left: 19.0, right: 19.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(156, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                  color: ColorResources().boxShadow,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: const Offset(
                    0.0,
                    10.0,
                  ),
                ),
              ],
            ),
            child: TextFormField(
              inputFormatters: inputFormatters,
              controller: textController,
              obscureText: isPasswordText != null && isPasswordText!
                  ? passWordVisible
                  : false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              maxLength: maxLength ?? 30,
              onChanged: onChanged,
              validator: validator,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: isPasswordText != null && isPasswordText!
                    ? InkWell(
                        onTap: _togglePasswordVisiblity,
                        child: Icon(
                          passWordVisible
                              ? IconsResources().visibilityOff
                              : IconsResources().visibility,
                          size: 25.0,
                        ))
                    : suffixIcon,
                counterText: "",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(width: .5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(width: .5),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: ColorResources().textColorBlack,
                  fontSize: 14,
                ),
              ),

              // textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: ColorResources().textColorBlack,
              ),
            ),
          ),
        );
      }),
    );
  }
}
