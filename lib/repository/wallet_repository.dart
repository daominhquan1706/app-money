import 'dart:convert';

import 'package:money_app/mock/record_mock.dart';
import 'package:money_app/model/wallet_model.dart';

class WalletRepository {
  WalletRepository._privateConstructor();
  static final WalletRepository instance =
      WalletRepository._privateConstructor();

  Future<List<Wallet>> getWallets() async {
    await Future.delayed(const Duration(seconds: 1));
    final list = (jsonDecode(fakeDataWallet) as List)
        .map<Wallet>((e) => Wallet.fromJson(e as Map<String, dynamic>))
        .toList();
    list.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    return list ?? [];
  }
}
