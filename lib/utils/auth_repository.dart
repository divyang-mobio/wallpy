import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wallpy/resources/resources.dart';
import '../resources/resources.dart';

class AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  Future<User> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result.user!;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(TextResources().failedErrorCode + e.code);
      }

      if (kDebugMode) {
        print(e.message);
      }
      throw e.message.toString();
    }
  }

  /// not working
  Future<bool> logout() async {
    try {
      await auth.signOut();

      return true;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(TextResources().failedErrorCode + e.code);
      }
      throw false;
    }
  }

  Future<User> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await result.user?.updateDisplayName(name);

      return result.user!;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(TextResources().failedErrorCode + e.code);
      }

      if (kDebugMode) {
        print(e.message);
      }
      throw e.message.toString();
    }
  }

  Future<void> forgotPasswordWithEmail(email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(TextResources().failedErrorCode + e.code);
      }
      if (kDebugMode) {
        print(e.message);
      }
      throw e.message.toString();
    }
  }
}
