import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_app/model/user_model.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'locator_service.dart';

class LoginManager {
  static LoginManager get instance => locator<LoginManager>();
  SharedPreferenceService prefsService = locator<SharedPreferenceService>();
  User user;

  Future login({@required String username, @required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login Fail, please try again";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      showFailDialog(errorMessage);
    }
  }

  Future<void> showFailDialog(String message) async {
    await DialogService().showDialog(
      title: 'Message',
      description: message,
      buttonTitle: "OK",
    );
  }

  Future<void> logout() async {
    user = null;
    prefsService.saveUserId(null);
    await FirebaseAuth.instance.signOut();
  }

  Future<void> setUser(User user) async {
    this.user = user;
    final newUser = AppUser(name: user.displayName, id: user.uid);
    prefsService.saveUserId(newUser);
  }
}
