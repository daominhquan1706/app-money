import 'package:flutter/cupertino.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/wallet_manager.dart';

class HomeViewModel with ChangeNotifier {
  final WalletManager _walletManager = WalletManager.instance;

  Wallet get currentWallet {
    return _walletManager.currentWallet;
  }

  Future<void> fetchData() async {
    await _walletManager.fetchHomeData();
    if (_walletManager.currentWallet == null &&
        _walletManager.listWallet.isNotEmpty) {
      _walletManager.onPickWallet(_walletManager.listWallet.first);
    } else if (_walletManager.listWallet.isEmpty) {
      final Wallet wallet = Wallet(
        name: "Ví mặc định",
        createdDate: DateTime.now(),
      );
      final createdWallet = await _walletManager.onCreateWallet(wallet);
      _walletManager.onPickWallet(createdWallet);
    } else {
      final currentWallet = _walletManager.currentWallet;
      _walletManager.onPickWallet(currentWallet);
    }

    notifyListeners();
  }

  void onPickWallet(Wallet wallet) {
    _walletManager.onPickWallet(wallet).then((value) => notifyListeners());
  }

  double get amountListRecord => [
        ..._walletManager.listRecordDisplay
            .map((e) => e.isAdd ? e.amount : 0 - e.amount),
        0.0,
      ].reduce((a, b) => a + b);

  List<Record> get listRecord {
    return _walletManager == null ? [] : _walletManager.listRecordDisplay;
  }

  void refresh() {
    notifyListeners();
  }
}
