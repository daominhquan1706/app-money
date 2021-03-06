import 'package:flutter/cupertino.dart';
import 'package:money_app/model/user_model.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  LoginViewModel() {
    fetchData();
  }

  static final LoginViewModel instance = LoginViewModel();

  SharedPreferenceService prefsService = SharedPreferenceService.instance;
  User user;
  bool isLoggedIn;

  void fetchData() {
    setUpSharedPreference();
    checkLogin();
  }

  Future setUpSharedPreference() async {
    prefsService.prefs ??= await SharedPreferences.getInstance();
    notifyListeners();
  }

  void checkLogin() {
    prefsService.getCurrentUser().then((value) {
      user = value;
      isLoggedIn = user != null;
      notifyListeners();
    });
  }

  void login() {
    print("Login");
    isLoggedIn = true;
    user = User(id: 1, name: "aasdfaf");
    notifyListeners();
  }

  void logout() {
    print("Logout");
    user = null;
    isLoggedIn = false;
    notifyListeners();
  }
}