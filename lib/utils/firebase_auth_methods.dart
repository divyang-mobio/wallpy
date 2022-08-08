import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseAuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  BuildContext? _dialogContext;

  closeLoader() {
    if (_dialogContext != null) {
      Navigator.pop(_dialogContext!);
      _dialogContext = null;
    }
  }

  Future<void> startLoader(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (buildContext) {
        _dialogContext = buildContext;
        return const SizedBox(
            height: 50,
            width: 50,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  static Future<User> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user!;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      throw e.message.toString();
    }
  }

  static Future<bool> logout() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      throw false;
    }
  }

  static Future<User> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user!;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      throw e.message.toString();
    }
  }

  static Future<void> forgotPasswordWithEmail(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      throw e.message.toString();
    }
  }
}
