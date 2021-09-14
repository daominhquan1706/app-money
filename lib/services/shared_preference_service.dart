import 'dart:convert';

import 'package:money_app/model/user_model.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService get instance => locator<SharedPreferenceService>();

  SharedPreferences prefs;
  static String USER_ID = 'user';
  static String CURRENT_WALLET_ID = 'current_walletId';

  Future saveUserId(AppUser user) async {
    if (user == null) {
      await prefs.setString(USER_ID, null);
      return;
    }
    prefs ??= await SharedPreferences.getInstance();
    final strUser = jsonEncode(user.toJson());
    await prefs.setString(USER_ID, strUser);
  }

  Future<AppUser> getUser() async {
    prefs ??= await SharedPreferences.getInstance();
    final strUser = prefs.getString(USER_ID);
    if (strUser != null) {
      final json = jsonDecode(strUser) as Map<String, dynamic>;
      return AppUser.fromJson(json);
    }
    return null;
  }

  Future changeWallet(String walletId) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs.setString(CURRENT_WALLET_ID, walletId);
  }

  Future<String> getCurrentWalletId() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs.getString(CURRENT_WALLET_ID);
  }
}
