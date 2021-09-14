import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_app/model/user_model.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

enum LoginState { login, register }

class LoginViewModel with ChangeNotifier {
  LoginViewModel() {
    fetchData();
  }

  LoginViewModel get instance => locator<LoginViewModel>();

  SharedPreferenceService prefsService = locator<SharedPreferenceService>();
  User user;
  bool _disposed = false;
  LoginState state = LoginState.login;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoggedIn = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future<void> fetchData() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      this.user = user;
      isLoggedIn = user != null;
      setUser(user);
      notifyListeners();
    });
    setUpSharedPreference();
  }

  Future setUpSharedPreference() async {
    prefsService.prefs ??= await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future login({@required String username, @required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
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

  Future<void> logout() async {
    user = null;
    prefsService.saveUserId(null);
    await FirebaseAuth.instance.signOut();
  }

  void changeState(LoginState state) {
    this.state = state;
    notifyListeners();
  }

  Future<void> setUser(User user) async {
    this.user = user;
    var newUser = AppUser(name: user.displayName, id: user.uid);
    prefsService.saveUserId(newUser);
  }
}
