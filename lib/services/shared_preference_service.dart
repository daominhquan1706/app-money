import 'dart:convert';

import 'package:money_app/model/user_model.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService get instance => locator<SharedPreferenceService>();

  SharedPreferences prefs;

  Future saveUser(User user) async {
    if (user == null) {
      await prefs.setString('user', null);
      return;
    }
    prefs ??= await SharedPreferences.getInstance();
    final strUser = jsonEncode(user.toJson());
    await prefs.setString('user', strUser);
  }

  Future<User> getUser() async {
    prefs ??= await SharedPreferences.getInstance();
    var strUser = prefs.getString('user');
    print(strUser);
    if (strUser != null) {
      final json = jsonDecode(strUser) as Map<String, dynamic>;
      return User.fromJson(json);
    }
    return null;
  }

  Future changeWallet(int walletId) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs.setInt('current_walletId', walletId);
  }

  Future<int> getCurrentWalletId() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs.getInt("current_walletId");
  }
}
