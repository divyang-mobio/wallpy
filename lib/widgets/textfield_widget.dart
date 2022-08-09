import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      this.textcontroller,
      this.inputFormatters})
      : super(key: key);
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool? isPasswordText;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController? textcontroller;
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
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                ),
              ],
            ),
            child: TextFormField(
              inputFormatters: inputFormatters,
              controller: textcontroller,
              obscureText: isPasswordText != null && isPasswordText!
                  ? passWordVisible
                  : false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,

              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$"))],
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
                              ? Icons.visibility_off
                              : Icons.visibility,
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
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),

              // textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }
}

Widget textformediter(BuildContext context,
    {String hintText = '',
    Function(String)? onChanged,
    String? Function(String?)? validator,
    int? maxLength,
    bool? isPasswordText,
    Widget? suffixIcon,
    TextEditingController? textcontroller,
    List<TextInputFormatter>? inputFormatters}) {
  bool passWordVisible = true;

  return Center(
    child:
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
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
            color: Colors.white24,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(
                  0.0,
                  10.0,
                ),
              ),
            ],
          ),
          child: TextFormField(
            inputFormatters: inputFormatters,
            controller: textcontroller,
            obscureText: isPasswordText != null && isPasswordText
                ? passWordVisible
                : false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            //inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$"))],
            maxLength: maxLength ?? 30,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
              labelText: hintText,
              suffixIcon: isPasswordText != null && isPasswordText
                  ? InkWell(
                      onTap: _togglePasswordVisiblity,
                      child: Icon(
                        passWordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 25.0,
                      ))
                  : suffixIcon,
              counterText: "",
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(width: .5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(width: .5),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),

            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontFamily: 'Montserrat'),
          ),
        ),
      );
    }),
  );
} 
















//   class Textfield extends StatelessWidget {
//   final TextEditingController controller;
//   final String hint;
//   final Icon icon;
//   final bool isPassword;
//   final Widget? suffix;
//   final IconButton? suffixIcon;

//   const Textfield(
//       {Key? key,
//       required this.controller,
//       required this.hint,
//       required this.icon,
//       required this.isPassword,
//       this.suffix,
//       this.suffixIcon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: TextField(
//         controller: controller,
//         maxLines: null,
//         obscureText: isPassword,
//         decoration: InputDecoration(
          




          
//           hintText: hint,
//           contentPadding: EdgeInsets.zero,
//           suffixIcon: suffixIcon,
//           prefixIcon: icon,
//           suffix: suffix,
//           filled: true,
//           fillColor: const Color.fromARGB(166, 255, 255, 255),
//           border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }
// }











