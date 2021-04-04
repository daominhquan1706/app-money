import 'package:flutter/cupertino.dart';
import 'package:money_app/model/user_model.dart';
import 'package:money_app/repository/login_repository.dart';
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
    prefsService.getUser().then((value) {
      user = value;
      isLoggedIn = user != null;
      notifyListeners();
    });
  }

  Future<String> login(
      {@required String username, @required String password}) async {
    await Future.delayed(const Duration(microseconds: 1));
    final data = await LoginRepository.instance.login(username, password);
    if (data["result"] != null) {
      final result = data["result"] as Map<String, dynamic>;
      await prefsService.saveUser(User.fromJson(result));

      isLoggedIn = true;
      notifyListeners();
      return null;
    } else {
      return data["message"] as String;
    }
  }

  Future<String> register(
      {@required String username, @required String password}) async {
    await Future.delayed(const Duration(microseconds: 1));
    final result = await LoginRepository.instance.register(username, password);
    if (result["result"] != null) {
      await prefsService
          .saveUser(User.fromJson(result["result"] as Map<String, dynamic>));
      isLoggedIn = true;
      notifyListeners();
      return null;
    } else {
      return result["message"] as String;
    }
  }

  void logout() {
    print("Logout");
    user = null;
    isLoggedIn = false;
    prefsService.saveUser(null);
    notifyListeners();
  }
}
