import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/services/login_manager.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

enum AuthPageType { login, register }
enum AuthState { loading, notLogin, loggedIn, error }

class LoginViewModel with ChangeNotifier {
  LoginViewModel() {
    fetchData();
  }

  LoginViewModel get instance => locator<LoginViewModel>();
  final LoginManager _loginManager = LoginManager.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthState authState = AuthState.loading;
  AuthPageType _state = AuthPageType.login;
  AuthPageType get state => _state;

  set state(AuthPageType value) {
    _state = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    authState = AuthState.loading;
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      _loginManager.setUser(user);
      authState = user == null ? AuthState.notLogin : AuthState.loggedIn;
      notifyListeners();
    });
  }

  Future login({@required String username, @required String password}) async {
    await _loginManager.login(username: username, password: password);
    notifyListeners();
  }

  Future register(
      {@required String username, @required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
