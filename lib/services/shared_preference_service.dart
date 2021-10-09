import 'dart:convert';

import 'package:money_app/model/user_model.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService get instance => locator<SharedPreferenceService>();

  SharedPreferences prefs;
  static const String userID = 'user';
  static String currentWalletID = 'current_walletId';

  Future saveUserId(AppUser user) async {
    if (user == null) {
      await prefs.setString(userID, null);
      return;
    }
    prefs ??= await SharedPreferences.getInstance();
    final strUser = jsonEncode(user.toJson());
    await prefs.setString(userID, strUser);
  }

  Future<AppUser> getUser() async {
    prefs ??= await SharedPreferences.getInstance();
    final strUser = prefs.getString(userID);
    if (strUser != null) {
      final json = jsonDecode(strUser) as Map<String, dynamic>;
      return AppUser.fromJson(json);
    }
    return null;
  }

  Future setWalletId(String walletId) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs.setString(currentWalletID, walletId);
  }

  Future<String> getCurrentWalletId() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs.getString(currentWalletID);
  }
}
