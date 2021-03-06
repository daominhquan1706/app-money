import 'dart:convert';

import 'package:money_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService._privateConstructor();
  static final SharedPreferenceService instance =
      SharedPreferenceService._privateConstructor();

  SharedPreferences prefs;

  Future changeWallet(int walletId) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs.setInt('current_walletId', walletId);
  }

  Future<int> getCurrentWalletId() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs.getInt("current_walletId");
  }

  Future<User> getCurrentUser() async {
    prefs ??= await SharedPreferences.getInstance();
    final user = prefs.getString("user");
    if (user == null) {
      return null;
    }
    return User.fromJson(jsonDecode(user) as Map<String, dynamic>);
  }
}
