import 'package:flutter/cupertino.dart';
import 'package:money_app/model/user_model.dart';
import 'package:money_app/repository/login_repository.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginState { login, register }

class LoginViewModel with ChangeNotifier {
  LoginViewModel() {
    fetchData();
  }

  LoginViewModel get instance => locator<LoginViewModel>();

  SharedPreferenceService prefsService = locator<SharedPreferenceService>();
  User user;
  bool isLoggedIn;
  bool _disposed = false;
  LoginState state = LoginState.login;

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

  Future login({@required String username, @required String password}) async {
    await Future.delayed(const Duration(microseconds: 1));
    final data = await LoginRepository.instance.login(username, password);
    if (data["result"] != null) {
      final result = data["result"] as Map<String, dynamic>;
      await prefsService.saveUser(User.fromJson(result));
      isLoggedIn = true;
      notifyListeners();
    }
  }

  Future register(
      {@required String username, @required String password}) async {
    await Future.delayed(const Duration(microseconds: 1));
    final result = await LoginRepository.instance.register(username, password);
    if (result["result"] != null) {
      await prefsService
          .saveUser(User.fromJson(result["result"] as Map<String, dynamic>));
      isLoggedIn = true;
      notifyListeners();
    }
  }

  void logout() {
    user = null;
    isLoggedIn = false;
    prefsService.saveUser(null);
    notifyListeners();
  }

  void changeState(LoginState state) {
    this.state = state;
    notifyListeners();
  }
}
