import 'package:money_app/model/wallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService._privateConstructor();
  static final SharedPreferenceService instance =
      SharedPreferenceService._privateConstructor();

  SharedPreferences prefs;

  Future changeWallet(int walletId) async {
    await prefs.setInt('current_walletId', walletId);
  }
}
