import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/services/login_manager.dart';

enum AuthPageType { login, register }
enum AuthState { loading, notLogin, loggedIn, error }

class LoginViewModel with ChangeNotifier {
  LoginViewModel() {
    fetchData();
  }

  LoginViewModel get instance => locator<LoginViewModel>();
  final LoginManager _loginManager = LoginManager.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthState _authState = AuthState.loading;
  AuthState get authState => _authState;
  set authState(AuthState value) {
    _authState = value;
    notifyListeners();
  }

  AuthPageType _pageType = AuthPageType.register;
  AuthPageType get pageType => _pageType;
  set pageType(AuthPageType value) {
    _pageType = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    authState = AuthState.loading;
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      authState = user == null ? AuthState.notLogin : AuthState.loggedIn;
      if (user == null) {
        return;
      }
      _loginManager.setUser(user);
      notifyListeners();
    });
  }

  Future<String> login(
      {@required String username, @required String password}) async {
    final message =
        await _loginManager.login(username: username, password: password);
    notifyListeners();
    return message;
  }

  Future<String> register(
      {@required String username, @required String password}) async {
    final message =
        await _loginManager.register(username: username, password: password);
    notifyListeners();
    return message;
  }
}
