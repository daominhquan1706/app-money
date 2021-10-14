import 'package:flutter/cupertino.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/wallet_manager.dart';

class ListWalletViewModel with ChangeNotifier {
  final WalletManager _walletManager = WalletManager.instance;

  List<Wallet> get listWallet {
    return _walletManager.listWallet;
  }

  Future<Wallet> onCreateWallet(Wallet wallet) async {
    final result = await _walletManager.onCreateWallet(wallet);
    notifyListeners();
    return result;
  }
}
