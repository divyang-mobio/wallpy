import 'package:wallpy/resources/resources.dart';

class Validator {
  static String? validateName({required String? name}) {
    // ignore: unnecessary_null_comparison
    if (name == null) {
      return TextResources().nameValidate;
    }
    if (name.isEmpty) {
      return TextResources().nameValidate;
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    // ignore: unnecessary_null_comparison
    if (email == null) {
      return TextResources().emailValidate;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return TextResources().emailValidate;
    } else if (!emailRegExp.hasMatch(email)) {
      return TextResources().enterEmail;
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    // ignore: unnecessary_null_comparison
    if (password == null) {
      return TextResources().passwordValidate;
    }
    if (password.isEmpty) {
      return TextResources().passwordValidate;
    } else if (password.length < 6) {
      return TextResources().enterPassword;
    }

    return null;
  }
}
