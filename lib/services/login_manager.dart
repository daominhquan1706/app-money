import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_app/helper/dialog_helper.dart';
import 'package:money_app/model/user_model.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'locator_service.dart';

class LoginManager {
  static LoginManager get instance => locator<LoginManager>();
  SharedPreferenceService prefsService = locator<SharedPreferenceService>();
  User user;

  Future<String> loginAnonymous() async {
    try {
      final UserCredential _ = await FirebaseAuth.instance.signInAnonymously();
      return "Login Success !";
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login Fail, please try again";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      return errorMessage;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> login(
      {@required String username, @required String password}) async {
    try {
      final UserCredential _ = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      return "Login Success !";
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login Fail, please try again";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      return errorMessage;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> register(
      {@required String username, @required String password}) async {
    try {
      final UserCredential _ = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);
      return "Register Success !";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak !";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email !";
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
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
    DialogHelper.showLoading();
    prefsService.saveUserId(null);
    prefsService.setWalletId(null);
    await FirebaseAuth.instance.signOut();
    DialogHelper.dismissLoading();
  }

  Future<void> setUser(User user) async {
    this.user = user;
    final newUser = AppUser(name: user.displayName, id: user?.uid);
    prefsService.saveUserId(newUser);
  }
}
